class_name ColorScoreMultiplier extends Node

@export var colors := ["cyan", "yellow", "magenta", "black"]
@export var score_multipliers := [0, 0, 0, 0]


func set_color_score_multiplier(color: String, multiplier: int) -> void:
	var color_index := colors.find(color.to_lower()); 
	if (color_index == -1): return;
	score_multipliers[color_index] = multiplier;

func update_color_score_multiplier(color: String, multiplier_delta: int) -> void:
	var color_index := colors.find(color.to_lower());
	if (color_index == -1): return;
	score_multipliers[color_index] += multiplier_delta;
	print(color + ": " + str(score_multipliers[color_index]))

	
func get_color_score_multiplier(index: int) -> int:
	if index > score_multipliers.size() - 1: return 0;
	return score_multipliers[index];


func clear_color_score_multiplier(color: String) -> void:
	var color_index := colors.find(color.to_lower());
	if (color_index == -1): return;
	score_multipliers[color_index] = 0;

	
func clear_all_multipliers() -> void:
	for sm in score_multipliers.size():
		score_multipliers[sm] = 0;
	
