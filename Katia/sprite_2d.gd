extends Sprite2D

@export var PieceColor: String

var matched = false;


func move(target):
	var tween = get_parent().create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(get_parent(), "position", target, 0.3)
	return tween

func visibility():
	modulate = Color(1, 1, 1, 0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
