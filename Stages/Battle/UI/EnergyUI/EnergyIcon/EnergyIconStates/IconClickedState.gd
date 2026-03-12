extends EnergyIconState

func enter() -> void:
	var uiLayer := get_tree().get_first_node_in_group(UI_LAYER_GROUP)
	if uiLayer:
		energyIcon.reparent(uiLayer)
	
	energyIcon.creatureStats.energyCount -= 1
	energyIcon.setAmount(0)

func onGuiInput(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		transitionRequested.emit(self, State.DRAGGING)
