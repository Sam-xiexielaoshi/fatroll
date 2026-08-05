class_name PlayerStateJump extends PlayerState

@export var jump_velocity : float = 450.0

func init() -> void:
	pass


#what happens when we enter this state
func enter() -> void:
	player.add_debug_indicator(Color.LIME_GREEN)
	player.velocity.y = -jump_velocity
	pass


# what happends when we exit this state
func exit() -> void:
	player.add_debug_indicator(Color.YELLOW)
	pass


#what happends when an input is pressed
func handle_input(event : InputEvent) -> PlayerState:
	if event.is_action_released("Jump"):
		player.velocity.y *= 0.5
		return fall
	return next_state


#what happens each process tick in this state?
func process(_delta: float) -> PlayerState:
	return next_state


#what happens each physics_process tick in this state?
func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		return idle
	elif player.velocity.y >= 0 :
		return fall
	player.velocity.x = player.direction.x * player.move_speed
	
	return next_state
