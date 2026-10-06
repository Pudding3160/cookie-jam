extends Control

@export var time_2_live := 1

func _ready() -> void:
	set_random_pos(-2, 2);
	var tween := create_tween();
	tween.set_parallel(true);
	tween.tween_property(self, "global_position", Vector2(self.global_position.x, self.global_position.y - 50), time_2_live);
	tween.tween_property(self, "modulate", Color8(1, 1, 1, 0), time_2_live).set_ease(tween.EASE_IN);
	await tween.finished;
	queue_free()
	
func set_text(time_decrease_value: float) -> void:
	var text_element := $CenterContainer/RichTextLabel;
	text_element.text = str(time_decrease_value).pad_decimals(2) + " seconds";
	
func set_random_pos(rng_min: float, rng_max: float) -> void:
	var start_pos := global_position;
	var rng := RandomNumberGenerator.new();
	global_position = start_pos + Vector2(rng.randf_range(rng_min, rng_max), rng.randf_range(rng_min, rng_max))