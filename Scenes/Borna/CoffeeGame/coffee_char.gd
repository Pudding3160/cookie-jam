extends CharacterBody2D

@export var speed := 800
@export var left_edge: Node2D
@export var right_edge: Node2D

func get_input():
	
	velocity = transform.x * Input.get_axis("CoffeeLeft", "CoffeeRight") * speed

func _physics_process(_delta):
	position.x = clamp(position.x, left_edge.position.x, right_edge.position.x)
	
	get_input()
	move_and_slide()
