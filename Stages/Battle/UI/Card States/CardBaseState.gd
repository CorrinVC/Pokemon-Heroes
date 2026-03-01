extends CardState

func enter() -> void:
	super.enter()
	cardUI.setScale(BASE_SCALE, BASE_SPEED)

func onMouseEntered() -> void:
	transitionRequested.emit(self, State.HOVER)
