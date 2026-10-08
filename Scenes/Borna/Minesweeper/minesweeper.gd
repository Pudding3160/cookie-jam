extends Node2D

var diff: float
func _enter_tree() -> void:
	
	scale_with_difficulty()
	
func scale_with_difficulty():
	var node := get_parent();
	var controller := node as DistractionControllerBase;
	diff= controller.get_difficulty(); 

func game_over() -> void:
	queue_free()
	
func get_difficulty() -> int:
	return diff;
