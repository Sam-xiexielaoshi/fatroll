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
	return next_state


#what happens each process tick in this state?
func process(_delta: float) -> PlayerState:
	if player.direction.x != 0:
		return run
	return next_state


#what happens each physics_process tick in this state?
func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = 0
	return next_state
