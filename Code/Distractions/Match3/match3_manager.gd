extends Node2D

@onready var grid := $Grid;
@export var score_per_match := 2	# This score is multiplied by a match multiplier that offers a bigger score for bigger matches
@export var cyan_score := 50
@export var yellow_score := 50
@export var magenta_score := 50
@export var black_score := 50
@export var csm: ColorScoreMultiplier
@export var cyan_text: RichTextLabel
@export var yellow_text: RichTextLabel
@export var magenta_text: RichTextLabel
@export var black_text: RichTextLabel

func _ready():
	update_text();

func calculate_score() -> void:
	for i in csm.score_multipliers.size():
		print(i);
		match csm.colors[i]:
			"cyan":				
				cyan_score -= score_per_match * csm.get_color_score_multiplier(i);
			"yellow":				
				yellow_score -= score_per_match * csm.get_color_score_multiplier(i);
			"magenta":				
				magenta_score -= score_per_match * csm.get_color_score_multiplier(i);
			"black":				
				black_score -= score_per_match * csm.get_color_score_multiplier(i);

	csm.clear_all_multipliers();
	if (cyan_score < 0): cyan_score = 0;
	if (yellow_score < 0): yellow_score = 0;
	if (magenta_score < 0): magenta_score = 0;
	if (black_score < 0): black_score = 0;
	update_text();

func update_text() -> void:
	cyan_text.text = "[color=#00FFFF]cyan required: " + str(cyan_score) + "[/color]";
	yellow_text.text = "[color=#FFFF00]yellow required: " + str(yellow_score) + "[/color]";
	magenta_text.text = "[color=#FF00FF]magenta required: " + str(magenta_score) + "[/color]";
	black_text.text = "[color=#000000]black required: " + str(black_score) + "[/color]";
