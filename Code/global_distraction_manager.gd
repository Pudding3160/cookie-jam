extends Node

var is_any_distraction_active := false;
var is_email_hard_mode := false
var time_decrease_modifier := 1.0;

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
func set_email_difficulty(is_hard_mode: bool) -> void:
	is_email_hard_mode = is_hard_mode;
	
func get_email_difficulty() -> bool:
	return is_email_hard_mode;


### ================== ###
### TIME DECREASE BUFF ###
### ================== ###
func set_time_decrease_modifier(modifier: float) -> void:
	time_decrease_modifier = modifier;

func get_time_decrease_modifier() -> float:
	return time_decrease_modifier;