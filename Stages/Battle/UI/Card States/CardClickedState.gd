extends CardState

func enter() -> void:
	battleCard.originalHandIndex = battleCard.get_index()
	battleCard.rotation_degrees = 0

func onInput(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		battleCard.dragOffset = battleCard.get_global_mouse_position() - battleCard.global_position
		transitionRequested.emit(self, State.DRAGGING)
