extends EnergyIconState

func enter() -> void:
	if energyIcon.target:
		energyIcon.attachEnergy()
		return
	
	if energyIcon.stacked:
		transitionRequested.emit.call_deferred(self, State.STACKED)
	else:
		transitionRequested.emit.call_deferred(self, State.SINGLE)
	
	energyIcon.adjustEnergyCount.call_deferred()
