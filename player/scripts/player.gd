class_name Player extends CharacterBody2D


func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity.x = 0
	if Input.is_action_pressed("Left"):
		velocity.x = -100
	elif Input.is_action_pressed("Right"):
		velocity.x = 100
	velocity.y+= 980 * delta
	move_and_slide()
	pass
