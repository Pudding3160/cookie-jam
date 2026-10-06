extends CharacterBody2D

@export var speed = 650

func get_input():
	
	velocity = transform.x * Input.get_axis("CoffeeLeft", "CoffeeRight") * speed

func _physics_process(delta):
	position.x = clamp(position.x, 435, 705)
	
	get_input()
	move_and_slide()
