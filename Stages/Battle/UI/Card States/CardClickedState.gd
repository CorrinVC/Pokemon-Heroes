extends CardState

func onInput(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		cardUI.dragOffset = cardUI.get_global_mouse_position() - cardUI.global_position
		transitionRequested.emit(self, State.DRAGGING)
