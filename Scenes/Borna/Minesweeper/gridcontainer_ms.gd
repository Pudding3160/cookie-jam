extends GridContainer

var tiles
var rnd = RandomNumberGenerator.new()
var bombs = []
var game_over = false
var open_to_win = 0


func _ready() -> void:
	randomize()
	tiles = get_children()

	for i in tiles.size():
		tiles[i].set_meta("is_bomb", false)
		tiles[i].set_meta("text_to_show", "")
		tiles[i].set_meta("revealed", false)
		tiles[i].pressed.connect(tile_clicked.bind(i))

	rand_bombs(2)

	for i in tiles.size():
		if not bombs.has(i):
			check_bombs(i)

	open_to_win = tiles.size() - bombs.size()


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
	else:
		get_tree().reload_current_scene()


func reveal(i):
	
	if tiles[i].get_meta("revealed"):
		return

	
	if tiles[i].get_meta("is_bomb"):
		tiles[i].text = "💣"
		game_over = true
		print("You lose!")
		return

	
	tiles[i].set_meta("revealed", true)
	tiles[i].text = tiles[i].get_meta("text_to_show")

	open_to_win -= 1

	
	if open_to_win == 0:
		game_over = true
		print("You win!")


func _process(delta: float) -> void:
	pass
