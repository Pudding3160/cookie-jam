extends Node

@onready var audio_fail := $"Fail Sound"
@onready var audio_penalty := $"Time Penalty Sound"
@onready var audio_match3_finished := $"M3 Finish"
@onready var audio_minigame_finished := $"Mini-game Finish"

func play_fail() -> void:
	audio_fail.play();

func play_penalty() -> void:
	audio_penalty.play();

func play_match3_complete() -> void:
	audio_match3_finished.play()

func play_mg_complete() -> void:
	audio_minigame_finished.play();
