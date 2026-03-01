extends CardState

const HOVER_SCALE: float = 1.5

func enter() -> void:
	super.enter()
	cardUI.setScale(HOVER_SCALE, BASE_SPEED)

func onGuiInput(event: InputEvent) -> void:
	if event.is_action_pressed(InputActions.LEFT_MOUSE):
		#cardUI.pivot_offset = cardUI.get_global_mouse_position() - cardUI.global_position
		transitionRequested.emit(self, State.CLICKED)

func onMouseExited() -> void:
	transitionRequested.emit(self, State.BASE)
