extends EnergyIconState

func enter() -> void:
	if energyIcon.stacked:
		transitionRequested.emit.call_deferred(self, State.STACKED)
		energyIcon.adjustEnergyCount()
	else:
		transitionRequested.emit.call_deferred(self, State.SINGLE)
