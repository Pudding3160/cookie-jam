extends Button

@export var time_decrease_per_click := -.25;
@export var time_decrease_indicator: PackedScene;

func _on_pressed() -> void:
	var total_time_decrease := time_decrease_per_click * GlobalDistractionManager.get_click_modifier()
	TimerManager.update_time(total_time_decrease);
	var child := time_decrease_indicator.instantiate();
	child.set_text(total_time_decrease);
	add_child(child);