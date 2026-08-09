class_name PlayerStateJump extends PlayerState

@export var jump_velocity : float = 450.0

func init() -> void:
	pass


#what happens when we enter this state
func enter() -> void:
	player.animation_player.play("jump")
	player.animation_player.pause()
	#player.add_debug_indicator(Color.LIME_GREEN)
	player.velocity.y = -jump_velocity
	pass


# what happends when we exit this state
func exit() -> void:
	#player.add_debug_indicator(Color.YELLOW)
	pass


#what happends when an input is pressed
func handle_input(event : InputEvent) -> PlayerState:
	if event.is_action_released("Jump"):
		player.velocity.y *= 0.5
		return fall
	return next_state


#what happens each process tick in this state?
func process(_delta: float) -> PlayerState:
	set_jump_frame()
	return next_state


#what happens each physics_process tick in this state?
func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		return idle
	elif player.velocity.y >= 0 :
		return fall
		
	# SILKSONG FAST-FALL: Increase downward velocity if pulling down on the stick/pad
	if player.direction.y > 0.5:
		player.velocity.y += player.gravity * _delta * 1.5 # Tailor this multiplier to feel right
	#quick snak air movement
	if player.direction.x != 0:
		player.velocity.x = player.direction.x * player.move_speed
	else:
		#if user released horizontal inpurts mid-air, velocity.x drops to 0 instantly 
		player.velocity.x = 0
	
	return next_state
	
	
func set_jump_frame() -> void:
	var frame : float = remap(player.velocity.y, -jump_velocity, 0.0, 0.0, 0.5)
	player.animation_player.seek(frame, true)
	pass
