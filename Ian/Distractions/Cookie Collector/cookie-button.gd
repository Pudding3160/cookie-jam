extends Button

@export var time_decrease_per_click: float;

func _on_pressed() -> void:
	TimerManager.update_time(time_decrease_per_click * GlobalDistractionManager.time_decrease_modifier);
