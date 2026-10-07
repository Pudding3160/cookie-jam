extends Control

@export var strikes: Array[Control]

func _process(_delta: float) -> void:
	var strike := GlobalStrikeManager.get_current_strikes() - 1;
	if strike < 0: return;
	if strike >= strikes.size(): return;
	strikes[strike].hide();
