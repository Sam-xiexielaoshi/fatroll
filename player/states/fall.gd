class_name PlayerStateFall extends PlayerState

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

	return next_state


#what happens each physics_process tick in this state?
func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor() :
		player.add_debug_indicator(Color.RED)
		return idle
	player.velocity.x = player.direction.x * player.move_speed

	return next_state
