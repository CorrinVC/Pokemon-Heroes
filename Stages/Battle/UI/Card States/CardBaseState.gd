extends CardState

func onMouseEntered() -> void:
	transitionRequested.emit(self, State.HOVER)
