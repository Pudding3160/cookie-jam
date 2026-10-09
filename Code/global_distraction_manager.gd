extends Node

enum EmailDifficulty {
	EASY,
	HARD
}

var is_any_distraction_active := false;
var email_difficulty := EmailDifficulty.EASY
var time_decrease_modifier := 1.0;
var warning_active := false;

### ================== ###
### DISTRACTION ACTIVE ###
### ================== ###
func set_distraction_active_state(is_distraction_active: bool) -> void:
	is_any_distraction_active = is_distraction_active;
	
func get_distraction_active_state() -> bool:
	return is_any_distraction_active;


### ================ ###
### EMAIL DIFFICULTY ###
### ================ ###
func set_email_difficulty(difficulty: EmailDifficulty) -> void:
	email_difficulty = difficulty;
	
func get_email_difficulty() -> EmailDifficulty:
	return email_difficulty;


### ================== ###
### TIME DECREASE BUFF ###
### ================== ###
func set_time_decrease_modifier(modifier: float) -> void:
	time_decrease_modifier = modifier;

func get_time_decrease_modifier() -> float:
	return time_decrease_modifier;


func set_warning(active: bool):
	warning_active = active;