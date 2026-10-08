extends DistractionControllerBase
func start_game() -> void:
	var scene_instance := distraction_scene.instantiate()
	scene_instance.position=Vector2(-80,-110)
	add_child(scene_instance);
	GlobalDistractionManager.set_distraction_active_state(true);
	attack_stored = false;
