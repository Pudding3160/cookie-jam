extends DistractionControllerBase

func start_game() -> void:
	var scene_instance := distraction_scene.instantiate()
	scene_instance.position=Vector2(-580,-480)
	add_child(scene_instance);
	GlobalDistractionManager.set_distraction_active_state(true);
	attack_stored = false;
	
func getdiff()->void: 
	difficulty=DifficultyManager.diffhons
func _ready() -> void:
	interval_buffer = interval;
	var node := get_node("/root/Main/RoomManager");
	if (node != null): room_manager = node as RoomManager;
	getdiff()
	print(difficulty)
	
