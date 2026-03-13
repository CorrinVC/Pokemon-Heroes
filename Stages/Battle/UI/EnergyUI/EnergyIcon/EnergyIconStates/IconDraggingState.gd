extends EnergyIconState

const MINIMUM_DRAG_DURATION: float = 0.05

var minimumDragTimeElapsed: bool = false

func enter() -> void:
	energyIcon.dragOffset = energyIcon.get_global_mouse_position() - \
		energyIcon.global_position
	
	var uiLayer := get_tree().get_first_node_in_group(UI_LAYER_GROUP)
	if uiLayer:
		energyIcon.reparent(uiLayer)
	
	energyIcon.creatureStats.energyCount -= 1
	
	minimumDragTimeElapsed = false
	var thresholdTimer := get_tree().create_timer(MINIMUM_DRAG_DURATION, false)
	thresholdTimer.timeout.connect(func() -> void: minimumDragTimeElapsed = true)

func onInput(event: InputEvent) -> void:
	var motion: bool = event is InputEventMouseMotion
	var release: bool = event.is_action_pressed(InputActions.LEFT_MOUSE) \
		or event.is_action_pressed(InputActions.RIGHT_MOUSE) \
		or event.is_action_released(InputActions.LEFT_MOUSE)
	
	if motion:
		energyIcon.global_position = energyIcon.get_global_mouse_position() - \
			energyIcon.dragOffset
	
	if release and minimumDragTimeElapsed:
		get_viewport().set_input_as_handled()
		transitionRequested.emit(self, State.RELEASED)
