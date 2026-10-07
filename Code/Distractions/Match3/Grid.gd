extends Node2D

enum {wait, move}
var state

#grid
@export var width: int
@export var height: int
@export var x_start: int
@export var y_start: int
@export var offset: int
@export var new_offset: int
@export var score_needed: float
@export var score_per_match := 5;
var matches_amount: int = 0;
@export var csm: ColorScoreMultiplier

var possible_pieces := [
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
	state = move
	randomize()
	all_pieces = make_array()
	spawn()


func make_array() -> Array:
	var array := []
	for column in width:
		array.append([])
		for row in height:
			array[column].append(null)
	return array


func spawn() -> void:
	for column in width:
		for row in height:
			var rand := floori(randf_range(0, possible_pieces.size()))
			var piece = possible_pieces[rand].instantiate()

			var loops := 0
			while check_match(column, row, piece.get_node("Sprite2D").PieceColor) and loops < 100:
				rand = floori(randf_range(0, possible_pieces.size()))
				loops += 1
				piece = possible_pieces[rand].instantiate()

			add_child(piece)
			piece.position = grid_to_pixel(column, row)
			all_pieces[column][row] = piece


#for no matches at beginning
func check_match(column: int, row: int, PieceColor: String):
	### ====================== ###
	### CHECKING FOR LEFT SIDE ###
	### ====================== ###
	if column > 1:		
		if all_pieces[column - 1][row] != null and all_pieces[column - 1][row] != null:			
			if all_pieces[column - 1][row].get_node("Sprite2D").PieceColor == PieceColor and all_pieces[column - 2][row].get_node("Sprite2D").PieceColor == PieceColor:				
				return true

	### ======================= ###
	### CHECKING FOR RIGHT SIDE ###
	### ======================= ###
	if column < width - 2:		
		if all_pieces[column + 1][row] != null and all_pieces[column + 1][row] != null:			
			if all_pieces[column + 1][row].get_node("Sprite2D").PieceColor == PieceColor and all_pieces[column + 2][row].get_node("Sprite2D").PieceColor == PieceColor:				
				return true

	### ====================== ###
	### CHECKING FOR UNDERSIDE ###
	### ====================== ###
	if row > 1:		
		if all_pieces[column][row - 1] != null and all_pieces[column][row - 1] != null:			
			if all_pieces[column][row - 1].get_node("Sprite2D").PieceColor == PieceColor and all_pieces[column][row - 2].get_node("Sprite2D").PieceColor == PieceColor:				
				return true

	### ======================= ###
	### CHECKING FOR ABOVE SIDE ###
	### ======================= ###
	if row < height - 2:		
		if all_pieces[column][row + 1] != null and all_pieces[column][row + 1] != null:			
			if all_pieces[column][row + 1].get_node("Sprite2D").PieceColor == PieceColor and all_pieces[column][row + 2].get_node("Sprite2D").PieceColor == PieceColor:				
				return true

	### ============================== ###
	### CHECKING FOR MIDDLE HORIZONTAL ###
	### ============================== ###
	if column < width - 1 and column > 0:		
		if all_pieces[column + 1][row] != null and all_pieces[column - 1][row] != null:			
			if all_pieces[column + 1][row].get_node("Sprite2D").PieceColor == PieceColor and all_pieces[column - 1][row].get_node("Sprite2D").PieceColor == PieceColor:				
				return true

	### ============================ ###
	### CHECKING FOR MIDDLE VERTICAL ###
	### ============================ ###
	if row < height - 1 and row > 0:		
		if all_pieces[column][row + 1] != null and all_pieces[column][row - 1] != null:			
			if all_pieces[column][row + 1].get_node("Sprite2D").PieceColor == PieceColor and all_pieces[column][row - 1].get_node("Sprite2D").PieceColor == PieceColor:				
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


func is_in_grid(grid_position):
	if grid_position.x >= 0 and grid_position.x < width:
		if grid_position.y >= 0 and grid_position.y < height:
			return true
	return false


func touch_input():
	if Input.is_action_just_pressed("ui_touch"):
		first_touch = pixel_to_grid(get_global_mouse_position().x, get_global_mouse_position().y)

		if is_in_grid(first_touch):
			controlling = true

	if Input.is_action_just_released("ui_touch"):
		final_touch = pixel_to_grid(get_global_mouse_position().x, get_global_mouse_position().y)

		if is_in_grid(final_touch) and controlling:
			touch_difference(first_touch, final_touch)

		controlling = false

#when we swap pieces that dont make a match
func match_prevent(column, row, direction):
	var first_piece = all_pieces[column][row]
	var second_piece = all_pieces[column + int(direction.x)][row + int(direction.y)]

	#swap and animate
	all_pieces[column][row] = second_piece
	all_pieces[column + int(direction.x)][row + int(direction.y)] = first_piece

	var first_tween = first_piece.get_node("Sprite2D").move(grid_to_pixel(column + int(direction.x), row + int(direction.y)))
	var second_tween = second_piece.get_node("Sprite2D").move(grid_to_pixel(column, row))
	await first_tween.finished
	await second_tween.finished

	if check_match(column + int(direction.x), 
			row + int(direction.y), 
			first_piece.get_node("Sprite2D").PieceColor) or check_match(
			column, 
			row, 
			second_piece.get_node("Sprite2D").PieceColor):
		find_matches()
	else:
		#swap back
		all_pieces[column][row] = first_piece
		all_pieces[column + int(direction.x)][row + int(direction.y)] = second_piece

		first_piece.get_node("Sprite2D").move(grid_to_pixel(column, row))
		second_piece.get_node("Sprite2D").move(grid_to_pixel(column + int(direction.x), row + int(direction.y)))

		state = move


func swap_pieces(column, row, direction):
	var first_piece = all_pieces[column][row]
	var second_piece = all_pieces[column + int(direction.x)][row + int(direction.y)]

	if first_piece != null and second_piece != null:
		state = wait
		match_prevent(column, row, direction)


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


func mark_matched(piece, color: String):
	piece.get_node("Sprite2D").matched = true
	piece.get_node("Sprite2D").visibility()
	csm.update_color_score_multiplier(color, 1);


func find_matches():
	var found_match := false

	for column in width:
		for row in height:
			if all_pieces[column][row] != null:
				var current_color = all_pieces[column][row].get_node("Sprite2D").PieceColor

				if column > 0 and column < width - 1:
					if all_pieces[column - 1][row] != null and all_pieces[column + 1][row] != null:
						if all_pieces[column - 1][row].get_node("Sprite2D").PieceColor == current_color and all_pieces[column + 1][row].get_node("Sprite2D").PieceColor == current_color:
							mark_matched(all_pieces[column - 1][row], current_color)
							mark_matched(all_pieces[column][row], current_color)
							mark_matched(all_pieces[column + 1][row], current_color)
							found_match = true

				if row > 0 and row < height - 1:
					if all_pieces[column][row - 1] != null and all_pieces[column][row + 1] != null:
						if all_pieces[column][row - 1].get_node("Sprite2D").PieceColor == current_color and all_pieces[column][row + 1].get_node("Sprite2D").PieceColor == current_color:
							mark_matched(all_pieces[column][row - 1], current_color)
							mark_matched(all_pieces[column][row], current_color)
							mark_matched(all_pieces[column][row + 1], current_color)
							found_match = true

	if found_match:
		get_parent().get_node("DestroyTimer").start()
	else:
		state = move


func destroy_matched():
	for column in width:
		for row in height:
			if all_pieces[column][row] != null:
				if all_pieces[column][row].get_node("Sprite2D").matched:
					all_pieces[column][row].queue_free()
					all_pieces[column][row] = null

	var parent := get_parent();
	if parent and parent.has_method("calculate_score"):
		parent.calculate_score();
	get_parent().get_node("CollapseTimer").start()


func collapse():
	for column in width:
		for row in height:
			if all_pieces[column][row] == null:
				for next_row in range(row + 1, height):
					if all_pieces[column][next_row] != null:
						all_pieces[column][next_row].get_node("Sprite2D").move(grid_to_pixel(column, row))
						all_pieces[column][row] = all_pieces[column][next_row]
						all_pieces[column][next_row] = null
						break

	get_parent().get_node("RefillTimer").start()


func refill():
	var tweens = []

	for column in width:
		for row in height:
			if all_pieces[column][row] == null:
				var rand = floori(randf_range(0, possible_pieces.size()))
				var piece = possible_pieces[rand].instantiate()

				var loops = 0
				while check_match(column, row, piece.get_node("Sprite2D").PieceColor) and loops < 100:
					rand = floori(randf_range(0, possible_pieces.size()))
					loops += 1
					piece = possible_pieces[rand].instantiate()

				add_child(piece)
				piece.position = grid_to_pixel(column, row + new_offset)

				var tween = piece.get_node("Sprite2D").move(grid_to_pixel(column, row))
				tweens.append(tween)

				all_pieces[column][row] = piece

	if tweens.size() > 0:
		await tweens[-1].finished

	refill_check()


#looks for a match after a refill
func refill_check():
	find_matches()


func _process(_delta):
	if state == move:
		touch_input()


func _on_destroy_timer_timeout() -> void:
	destroy_matched()


func _on_collapse_timer_timeout() -> void:
	collapse()


func _on_refill_timer_timeout() -> void:
	refill()


func end_game(failed: bool) -> void:
	if (failed):
		GlobalStrikeManager.update_strikes(1);
	queue_free();
