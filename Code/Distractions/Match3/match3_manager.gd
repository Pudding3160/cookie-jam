extends Node2D

@onready var grid := $Grid;
@onready var progress_bar := $Control/VBoxContainer/MarginContainer2/ProgressBar
@export var score_per_match := 2	# This score is multiplied by a match multiplier that offers a bigger score for bigger matches
@export var score_needed := 50
var cyan_score: int
var yellow_score: int
var magenta_score: int
var black_score: int
@export var csm: ColorScoreMultiplier
@export var cyan_text: RichTextLabel
@export var yellow_text: RichTextLabel
@export var magenta_text: RichTextLabel
@export var black_text: RichTextLabel
@export var duration: float = 50
@export var time_penalty: float = 10

func _ready():
	scale_with_difficulty();
	progress_bar.max_value = duration;
	progress_bar.value = duration;
	update_text();
	
func _process(delta: float) -> void:
	duration -= delta;
	update_progress_bar();
	if duration > 0.0: return;
	end_game(true);

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
	if check_for_game_finished(): end_game(false);

func update_text() -> void:
	cyan_text.text = "[color=#00FFFF]cyan required: " + str(cyan_score) + "[/color]";
	yellow_text.text = "[color=#FFFF00]yellow required: " + str(yellow_score) + "[/color]";
	magenta_text.text = "[color=#FF00FF]magenta required: " + str(magenta_score) + "[/color]";
	black_text.text = "[color=#000000]black required: " + str(black_score) + "[/color]";


func update_progress_bar() -> void:
	progress_bar.value = duration;


func check_for_game_finished() -> bool:
	if cyan_score != 0: return false;
	if yellow_score != 0: return false;
	if magenta_score != 0: return false;
	if black_score != 0: return false;
	return true;


func scale_with_difficulty() -> void:
	var node := get_parent();
	var controller := node as DistractionControllerBase;
	var diff: float = controller.get_difficulty();
	duration = 6 * log(diff + 1.0) + duration;	# If time needs to be extended, increase duration; if the difficulty curve needs to be harder, increase the first number;
	time_penalty = 15 * log(diff + 1.0) + time_penalty;	# If the time penalty needs to be increased, increase time_penalty; if the difficulty curve needs to be harder, increase the first number
	score_needed = ceil(10 * log(diff + 1.0) + score_needed);
	set_color_scores();


func set_color_scores():
	cyan_score = score_needed;
	yellow_score = score_needed;
	magenta_score = score_needed;
	black_score = score_needed;

func end_game(failed: bool) -> void:
	if (failed):
		GlobalStrikeManager.update_strikes(1);
		TimerManager.update_time(time_penalty)
	queue_free();
