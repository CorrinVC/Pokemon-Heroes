extends CardState

func enter() -> void:
	battleCard.reparentRequested.emit(battleCard)

func onMouseEntered() -> void:
	transitionRequested.emit(self, State.HOVER)
