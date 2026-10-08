extends GridContainer

var tiles
var rnd = RandomNumberGenerator.new()
var bombs = []
var game_over = false
var open_to_win = 0
var bombnum
var node
@onready var yay=$"../Yay"
@onready var click=$"../click"
@onready var bomb=$"../bomb"


@onready var tile_empty = preload("res://Scenes/Borna/Minesweeper/Sweepersprites/empty.png")
@onready var tile_covered= preload("res://Scenes/Borna/Minesweeper/Sweepersprites/covered.png")
@onready var tile_1 = preload("res://Scenes/Borna/Minesweeper/Sweepersprites/1.png")
@onready var tile_2 = preload("res://Scenes/Borna/Minesweeper/Sweepersprites/2.png")
@onready var tile_3 = preload("res://Scenes/Borna/Minesweeper/Sweepersprites/3.png")
@onready var tile_4 = preload("res://Scenes/Borna/Minesweeper/Sweepersprites/4.png")
@onready var tile_5 = preload("res://Scenes/Borna/Minesweeper/Sweepersprites/5.png")
@onready var tile_6 = preload("res://Scenes/Borna/Minesweeper/Sweepersprites/6.png")
@onready var tile_7 = preload("res://Scenes/Borna/Minesweeper/Sweepersprites/7.png")
@onready var tile_8 = preload("res://Scenes/Borna/Minesweeper/Sweepersprites/8.png")
@onready var tile_bomb = preload("res://Scenes/Borna/Minesweeper/Sweepersprites/bomb.png")


var number_textures = []


func _ready() -> void:
	number_textures = [
	tile_empty, # 0
	tile_1,     # 1
	tile_2,     # 2
	tile_3,     # 3
	tile_4,     # 4
	tile_5,     # 5
	tile_6,     # 6
	tile_7,     # 7
	tile_8      # 8
]
	
	node = get_parent();
	scale_with_difficulty()
	randomize()
	tiles = get_children()
	print(bombnum)
	for i in tiles.size():
		tiles[i].set_meta("is_bomb", false)
		tiles[i].set_meta("text_to_show", "")
		tiles[i].set_meta("revealed", false)
		tiles[i].pressed.connect(tile_clicked.bind(i))

	rand_bombs(bombnum)

	for i in tiles.size():
		if not bombs.has(i):
			check_bombs(i)

	open_to_win = tiles.size() - bombs.size()
	
func scale_with_difficulty() -> void:
	
	var diff= node.get_difficulty(); 
	print(diff)
	bombnum= int(ceil(2 + diff / 3))
	
	
	

func check_bombs(index):
	var num_of_bombs = 0

	for i in bombs.size():
		if are_adjecent(index, bombs[i], get_columns()):
			num_of_bombs += 1

	tiles[index].set_meta("text_to_show", str(num_of_bombs))


func are_adjecent(index, bomb, cols):
	var ca = to_cords(index, cols)
	var cb = to_cords(bomb, cols)

	var diff = (ca - cb).abs()

	return diff.x <= 1 and diff.y <= 1 and not (ca == cb)


func to_cords(position, cols):
	return Vector2i(position / cols, position % cols)


func rand_bombs(num_of_bombs):
	while bombs.size() < num_of_bombs:
		var new_bomb_at = rnd.randi_range(0, tiles.size() - 1)

		if not bombs.has(new_bomb_at):
			bombs.append(new_bomb_at)

	for i in bombs.size():
		tiles[bombs[i]].set_meta("is_bomb", true)


func tile_clicked(i):
	if not game_over:
		reveal(i)
	


func reveal(i):
	
	if tiles[i].get_meta("revealed"):
		return

	
	if tiles[i].get_meta("is_bomb"):
		tiles[i].texture_normal = tile_bomb
		bomb.play()
		await get_tree().create_timer(1.0).timeout
		game_over = true
		node.game_over()
		return

	
	tiles[i].set_meta("revealed", true)
	var number = int(tiles[i].get_meta("text_to_show"))
	tiles[i].texture_normal = number_textures[number]
	click.play()
	print("click")
	open_to_win -= 1

	
	if open_to_win == 0:
		yay.play()
		await get_tree().create_timer(1.0).timeout
		
		game_over = true
		node.game_over()
		print("You win!")


func _process(delta: float) -> void:
	pass
