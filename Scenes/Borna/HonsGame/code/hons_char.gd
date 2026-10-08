extends CharacterBody2D
const grav: int=1000
const jump : int=-400

func _physics_process(delta):
	
	velocity.y += grav*delta
	if is_on_floor():
		if Input.is_action_just_pressed("HonsJump"):
			$AudioStreamPlayer2D.play()
			velocity.y=jump
		elif Input.is_action_pressed("HonsDown"):
			$AnimatedSprite2D.play("Crouch")
			$Run.disabled=true
		else:
			$Run.disabled=false	
			$AnimatedSprite2D.play("Run")	
	else:
		$AnimatedSprite2D.play("Jump")	
	move_and_slide()
		
