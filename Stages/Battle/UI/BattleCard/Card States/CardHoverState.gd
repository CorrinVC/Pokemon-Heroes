extends CardState

const BASE_SCALE: float = 1.0
const HOVER_SCALE: float = 1.2

func enter() -> void:
	super.enter()
	battleCard.setScale(HOVER_SCALE, BattleCard.BASE_SPEED)

func exit() -> void:
	battleCard.setScale(BASE_SCALE, BattleCard.BASE_SPEED)

func onGuiInput(event: InputEvent) -> void:
	if not battleCard.playable:
		return
	
	if event.is_action_pressed(InputActions.LEFT_MOUSE):
		transitionRequested.emit(self, State.CLICKED)

func onMouseExited() -> void:
	transitionRequested.emit(self, State.BASE)
