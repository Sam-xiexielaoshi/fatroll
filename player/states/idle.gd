class_name PlayerStateIdle extends PlayerState

func init() -> void:
	pass


#what happens when we enter this state
func enter() -> void:
	pass


# what happends when we exit this state
func exit() -> void:
	pass


#what happends when an input is pressed
func handle_input(_event : InputEvent) -> PlayerState:
	if _event.is_action_pressed("Jump"):
		return jump
	return next_state


#what happens each process tick in this state?
func process(_delta: float) -> PlayerState:
	if player.direction.x != 0:
		return run
	return next_state


#what happens each physics_process tick in this state?
func physics_process(_delta: float) -> PlayerState:
	# Snaps perfectly to 0 to prevent sliding off tiny single-tile pillars
	player.velocity.x = 0
	if player.is_on_floor() == false:
		return fall
	return next_state
