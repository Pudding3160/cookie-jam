extends Control

@onready var first_child := get_child(0);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (GlobalDistractionManager.get_distraction_active_state()): first_child.show();
	else: first_child.hide();
