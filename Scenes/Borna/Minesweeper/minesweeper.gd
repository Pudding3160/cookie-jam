extends Node2D

var diff: float

func _enter_tree() -> void:	
	scale_with_difficulty()
	
func scale_with_difficulty():
	var node := get_parent();
	var controller := node as DistractionControllerBase;
	diff= controller.get_difficulty(); 

func game_over(failed: bool) -> void:
	if (failed):
		GlobalStrikeManager.update_strikes(1);
		GlobalDistractionManager.set_email_difficulty(true);
	else:
		GlobalSoundManager.play_mg_complete();
	
	GlobalDistractionManager.set_distraction_active_state(false);
	queue_free()
	
func get_difficulty() -> int:
	return diff;


func _on_timer_timeout() -> void:
	game_over(true);
