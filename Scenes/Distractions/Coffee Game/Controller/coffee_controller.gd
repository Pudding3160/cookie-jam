class_name CoffeeController extends DistractionControllerBase


func get_diff()->void: 
	difficulty=DifficultyManager.diffCoffee
	
func start_game() -> void:
	var scene_instance := distraction_scene.instantiate();
	add_child(scene_instance);
	attack_stored = false;
