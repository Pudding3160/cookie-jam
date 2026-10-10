class_name Match3Controller extends DistractionControllerBase

@onready var warning := preload("res://Scenes/Distraction Warning/danger_icon.tscn");

func start_game() -> void:
	var scene_instance := distraction_scene.instantiate();
	add_child(scene_instance);
	
	# Sound the alarm
	if (RoomManager.current_room_type != active_room):
		var warning_scene := warning.instantiate();
		add_child(warning_scene);
	
	attack_stored = false;
	

func get_diff()->void: 
	difficulty=DifficultyManager.diffmatch3

func set_children_state(active: bool) -> void:
	if (get_child_count() == 0): return;
	var child := get_child(0)
	if (child == null): return;
	if (active): child.show();
	else: child.hide();