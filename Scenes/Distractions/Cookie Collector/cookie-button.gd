extends Button

@export var time_decrease_per_click := -.25;
@export var time_decrease_indicator: PackedScene;
@export var idle_sprite: Texture
@export var pressed_sprite: Texture

func _ready() -> void:
	icon = idle_sprite

func _on_pressed() -> void:
	var total_time_decrease := time_decrease_per_click * GlobalDistractionManager.get_click_modifier()
	TimerManager.update_time(total_time_decrease);
	var child := time_decrease_indicator.instantiate();
	child.set_text(total_time_decrease);
	add_child(child);

func _on_button_down() -> void:
	icon = pressed_sprite


func _on_button_up() -> void:
	icon = idle_sprite
