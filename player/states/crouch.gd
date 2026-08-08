class_name PlayerStateCrouch extends PlayerState

@export var deceleration_rate : float = 10

func init() -> void:
	pass


#what happens when we enter this state
func enter() -> void:
	player.animation_player.play("crouch")
	player.collision_stand.disabled = true
	player.collision_crouch.disabled = false
	pass


# what happends when we exit this state
func exit() -> void:
	player.collision_stand.disabled = false
	player.collision_crouch.disabled = true
	pass


#what happends when an input is pressed
func handle_input(_event : InputEvent) -> PlayerState:
	if _event.is_action_pressed("Jump"):
		player.one_way_platform_shape_cast.force_shapecast_update()
		if player.one_way_platform_shape_cast.is_colliding() == true and player.current_state == crouch:
			player.position.y += 4.0
			return fall
		return jump
	return next_state


#what happens each process tick in this state?
func process(_delta: float) -> PlayerState:
	if player.direction.y <= 0.5:
		return idle
	return next_state


#what happens each physics_process tick in this state?
func physics_process(_delta: float) -> PlayerState:
	# Snaps perfectly to 0 to prevent sliding off tiny single-tile pillars
	player.velocity.x = 0
	if player.is_on_floor() == false:
		return fall
	return next_state
