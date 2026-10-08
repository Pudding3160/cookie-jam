class_name StrikeNotch extends Control

@export var strike: Texture2D;
@onready var panel := $Panel;
@onready var texture_rect := $TextureRect
var is_enabled: bool = true

func disable_strike() -> void:
	if (!is_enabled): return;
	is_enabled = false;
	panel.show();
	texture_rect.hide();
	
func enable_strike() -> void:
	if (is_enabled): return;
	is_enabled = true;
	panel.hide();
	texture_rect.show();
	var tween := create_tween();
	tween.tween_property(texture_rect, "scale", Vector2(2, 2), .2).set_ease(Tween.EASE_OUT)
	tween.tween_property(texture_rect, "scale", Vector2(1, 1), .15).set_ease(Tween.EASE_OUT)
	
