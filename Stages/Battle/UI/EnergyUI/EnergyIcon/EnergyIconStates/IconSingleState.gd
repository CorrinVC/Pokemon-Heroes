extends EnergyIconState

func enter() -> void:
	energyIcon.reparentRequested.emit(energyIcon)

func onGuiInput(event: InputEvent) -> void:
	if event.is_action_pressed(InputActions.LEFT_MOUSE):
		#energyIcon.originalPosition = energyIcon.global_position
		transitionRequested.emit(self, State.DRAGGING)
