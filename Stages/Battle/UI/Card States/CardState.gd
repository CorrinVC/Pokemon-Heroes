class_name CardState extends Node

signal transitionRequested(from: CardState, to: State)

enum State {
	BASE,
	HOVER,
	CLICKED,
	DRAGGING,
	RELEASED
}

@export var state: State

var battleCard: BattleCard

func enter() -> void:
	battleCard.stateLabel.text = str(State.keys()[state])

func exit() -> void:
	pass

func onInput(_event: InputEvent) -> void:
	pass

func onGuiInput(_event: InputEvent) -> void:
	pass

func onMouseEntered() -> void:
	pass

func onMouseExited() -> void:
	pass
