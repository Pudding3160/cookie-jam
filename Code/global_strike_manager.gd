extends Node

var max_strikes := 5
var current_strikes := 0

func update_strikes(delta: int) -> void:
	current_strikes += delta;
	print(current_strikes)
	
func get_current_strikes() -> int:
	return current_strikes;