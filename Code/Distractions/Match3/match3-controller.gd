class_name Match3Controller extends DistractionControllerBase

@onready var warning := preload("res://Scenes/Distraction Warning/danger_icon.tscn");

func start_game() -> void:
	var scene_instance := distraction_scene.instantiate();
	add_child(scene_instance);
	
	# Sound the alarm
	if (room_manager.current_room_type != active_room):
		var warning_scene := warning.instantiate();
		add_child(warning_scene);
	
	attack_stored = false;
	

func getdiff()->void: 
	difficulty=DifficultyManager.diffmatch3
func _ready() -> void:
	interval_buffer = interval;
	var node := get_node("/root/Main/RoomManager");
	if (node != null): room_manager = node as RoomManager;
	getdiff()
	print(difficulty)
