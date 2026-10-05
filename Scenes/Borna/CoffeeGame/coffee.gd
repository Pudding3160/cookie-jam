extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	position.y+=1.6
	#get_parent().speed
	if position.y>=460:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	print("Something entered: ", body)

	if body is CharacterBody2D:
		print("CharacterBody2D detected!")
		queue_free()
