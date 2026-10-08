extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$AnimatedSprite2D.play("Fly")
	position.x-=get_parent().speed
	if position.x<=150:
		queue_free()
