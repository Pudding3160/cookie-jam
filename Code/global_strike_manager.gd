extends Node

var max_strikes := 5
var current_strikes := 0

func update_strikes(delta: int) -> void:
	if (delta > 0): GlobalSoundManager.play_fail();
	current_strikes += delta;
	
func get_current_strikes() -> int:
	return current_strikes;

func _process(_delta: float) -> void:
	if (current_strikes < max_strikes): return;
	print("game over");