class_name CoffeeController extends DistractionControllerBase


func getdiff()->void: 
	difficulty=DifficultyManager.diffCoffee
func _ready() -> void:
	interval_buffer = interval;
	var node := get_node("/root/Main/RoomManager");
	if (node != null): room_manager = node as RoomManager;
	getdiff()
	print(difficulty)
func start_game() -> void:
	var scene_instance := distraction_scene.instantiate();
	add_child(scene_instance);
	attack_stored = false;
