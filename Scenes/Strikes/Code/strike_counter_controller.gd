extends Control

@export var strikes: Array[StrikeNotch]

func _ready() -> void:
	for strike in strikes:
		strike.disable_strike();

func _process(_delta: float) -> void:
	var strike_index := GlobalStrikeManager.get_current_strikes() - 1;
	if strike_index < 0 or strike_index >= strikes.size(): return;
	var strike: StrikeNotch = strikes[strike_index];
	strike.enable_strike();
