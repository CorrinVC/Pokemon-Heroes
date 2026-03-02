extends CardState

func onInput(event: InputEvent) -> void:
	var motion: bool = event is InputEventMouseMotion
	var cancel: bool = event.is_action_pressed(InputActions.RIGHT_MOUSE)
	var confirm: bool = event.is_action_released(InputActions.LEFT_MOUSE) \
		or event.is_action_pressed(InputActions.LEFT_MOUSE)
	
	if motion:
		battleCard.global_position = battleCard.get_global_mouse_position() - battleCard.dragOffset
	
	if cancel:
		transitionRequested.emit(self, State.BASE)
	elif confirm:
		transitionRequested.emit(self, State.RELEASED)
