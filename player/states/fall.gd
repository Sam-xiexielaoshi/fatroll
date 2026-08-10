class_name PlayerStateFall extends PlayerState

@export var fall_gravity_multiplier : float = 1.165
@export var coyote_time : float = 0.125
@export var jump_buffer_time : float = 0.2

var coyote_timer : float = 0
var buffer_timer : float = 0

func init() -> void:
	pass


#what happens when we enter this state
func enter() -> void:
	player.animation_player.play("jump")
	player.animation_player.pause()
	player.gravity_multiplier = fall_gravity_multiplier
	if player.previous_state == jump:
		coyote_timer = 0
	else:
		coyote_timer = coyote_time
	pass


# what happends when we exit this state
func exit() -> void:
	player.gravity_multiplier = 1.0
	buffer_timer = 0
	pass


#what happends when an input is pressed
func handle_input(_event : InputEvent) -> PlayerState:
	if _event.is_action_pressed("Jump"):
		if coyote_timer > 0 :
			return jump
		else:
			buffer_timer = jump_buffer_time
	return next_state


#what happens each process tick in this state?
func process(_delta: float) -> PlayerState:
	coyote_timer -= _delta
	buffer_timer -= _delta
	set_jump_frame()
	return next_state


#what happens each physics_process tick in this state?
func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor() :
		#player.add_debug_indicator(Color.RED)
		if buffer_timer > 0 and Input.is_action_pressed("Jump"):
			return jump
		return idle
	# SILKSONG FAST-FALL: Accelerate the gravity multiplier mid-fall if holding Down
	if player.direction.y > 0.5:
		player.gravity_multiplier = fall_gravity_multiplier * 2.0 # Drastically cuts fall time
	else:
		player.gravity_multiplier = fall_gravity_multiplier
	#responsive airborne controls
	if player.direction.x != 0 :
		player.velocity.x = player.direction.x * player.move_speed
	else :
		player.velocity.x = 0

	return next_state
	
	
func set_jump_frame() -> void:
	var frame : float = remap(player.velocity.y, 0.0, player.max_fall_velocity, 0.0, 0.5)
	player.animation_player.seek(frame, true)
	pass
