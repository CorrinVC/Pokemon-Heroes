extends CardState

func onInput(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		battleCard.dragOffset = battleCard.get_global_mouse_position() - battleCard.global_position
		transitionRequested.emit(self, State.DRAGGING)
