extends Node

@export var set_diff: int;
@export var diff_controller: CustomShift

func _on_pressed() -> void:
	diff_controller.set_all_to(set_diff);
	
