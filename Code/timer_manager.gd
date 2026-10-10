extends Node

var time := 340.0
var time_buffer: float;
var time_decrease_modifer := .1;
@onready var next_scene := preload("res://Scenes/Cutscenes/good ending/good_end.tscn")
var can_change := true;
var main_game: Node

func _ready() -> void:
	reset();

func _process(delta: float) -> void:
	if time_buffer > 0:
		update_time(-delta * time_decrease_modifer);
		return;
	
	if (!can_change): return;
	end_game();


func update_time(delta: float, is_penalty := false):
	main_game = get_tree().root.get_child(-1);
	if (time_buffer <= 0): return;
	if is_penalty: GlobalSoundManager.play_penalty();
	time_buffer += delta;

func get_current_time() -> float:
	return time_buffer;

func get_time_modifier() -> float:
	return time_decrease_modifer;

func end_game():
	var result: bool = await SceneTransition.fade_in();
	if result:
		var scene := next_scene.instantiate();
		get_tree().root.add_child(scene);
		SceneTransition.fade_out();
		RoomManager.clear_children();
		GlobalDistractionManager.reset()
		GlobalStrikeManager.reset()
		main_game.queue_free()
		reset()

func reset():
	time_buffer = time;
	time_decrease_modifer = .1;
	can_change = true;