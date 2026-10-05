
extends Node2D

#grid
@export var width: int
@export var height: int
@export var x_start: int
@export var y_start: int
@export var offset: int


var possible_pieces = [
	preload("res://Katia/BlackPiece.tscn"),
	preload("res://Katia/CyanPiece.tscn"),
	preload("res://Katia/MagentaPiece.tscn"),
	preload("res://Katia/YellowPiece.tscn"),
]

#pieces in scene
var all_pieces = []

var first_touch = Vector2(0, 0)
var final_touch = Vector2(0, 0)

var controlling = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	all_pieces = make_array()
	spawn()


func make_array() -> Array:
	var array = []
	for i in width:
		array.append([])
		for j in height:
			array[i].append(null)
	return array


func spawn() -> void:
	for i in width:
		for j in height:
			var rand = floori(randf_range(0, possible_pieces.size()))
			var piece = possible_pieces[rand].instantiate()

			var loops = 0
			while check_match(i, j, piece.get_node("Sprite2D").PieceColor) and loops < 100:
				rand = floori(randf_range(0, possible_pieces.size()))
				loops += 1
				piece = possible_pieces[rand].instantiate()

			add_child(piece)
			piece.position = grid_to_pixel(i, j)
			all_pieces[i][j] = piece


#for no matches at beginning
func check_match(i, j, PieceColor):
	if i > 1:
		if all_pieces[i - 1][j] != null and all_pieces[i - 2][j] != null:
			if all_pieces[i - 1][j].get_node("Sprite2D").PieceColor == PieceColor and all_pieces[i - 2][j].get_node("Sprite2D").PieceColor == PieceColor:
				return true

	if j > 1:
		if all_pieces[i][j - 1] != null and all_pieces[i][j - 2] != null:
			if all_pieces[i][j - 1].get_node("Sprite2D").PieceColor == PieceColor and all_pieces[i][j - 2].get_node("Sprite2D").PieceColor == PieceColor:
				return true

	return false


func grid_to_pixel(column, row):
	var new_x = x_start + offset * column
	var new_y = y_start + -offset * row
	return Vector2(new_x, new_y)


func pixel_to_grid(pixel_x, pixel_y):
	var new_x = roundi((pixel_x - x_start) / offset)
	var new_y = roundi((pixel_y - y_start) / -offset)
	return Vector2(new_x, new_y)


func is_in_grid(column, row):
	if column >= 0 and column < width:
		if row >= 0 and row < height:
			return true
	return false


func touch_input():
	if Input.is_action_just_pressed("ui_touch"):
		first_touch = get_global_mouse_position()
		var grid_position = pixel_to_grid(first_touch.x, first_touch.y)

		if is_in_grid(grid_position.x, grid_position.y):
			controlling = true

	if Input.is_action_just_released("ui_touch"):
		final_touch = get_global_mouse_position()
		var grid_position = pixel_to_grid(final_touch.x, final_touch.y)

		if is_in_grid(grid_position.x, grid_position.y) and controlling:
			touch_difference(
				pixel_to_grid(first_touch.x, first_touch.y),
				grid_position
			)

		controlling = false


func swap_pieces(column, row, direction):
	var first_piece = all_pieces[column][row]
	var second_piece = all_pieces[column + direction.x][row + direction.y]

	all_pieces[column][row] = second_piece
	all_pieces[column + direction.x][row + direction.y] = first_piece

	first_piece.position = grid_to_pixel(column + direction.x, row + direction.y)
	second_piece.position = grid_to_pixel(column, row)


func touch_difference(grid_1, grid_2):
	var difference = grid_2 - grid_1

	#ako je diff za X veci od Y
	if abs(difference.x) > abs(difference.y):
		if difference.x > 0:
			swap_pieces(grid_1.x, grid_1.y, Vector2(1, 0))
		elif difference.x < 0:
			swap_pieces(grid_1.x, grid_1.y, Vector2(-1, 0))

	elif abs(difference.y) > abs(difference.x):
		if difference.y > 0:
			swap_pieces(grid_1.x, grid_1.y, Vector2(0, 1))
		elif difference.y < 0:
			swap_pieces(grid_1.x, grid_1.y, Vector2(0, -1))


func _process(_delta):
	touch_input()
