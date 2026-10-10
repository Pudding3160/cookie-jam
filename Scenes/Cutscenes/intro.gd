extends Node2D

@onready var timer := $Timer
@export var next_scene: PackedScene

func _on_timer_timeout() -> void:
	var result: bool = await SceneTransition.fade_in();
	if result:
		var scene := next_scene.instantiate();
		get_tree().root.add_child(scene);
		SceneTransition.fade_out();
		queue_free();