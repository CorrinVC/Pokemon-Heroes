class_name CardState extends Node

signal transitionRequested(from: CardState, to: State)

const BASE_SCALE: float = 1.0
const BASE_SPEED: float = 0.03

enum State {
	BASE,
	HOVER,
	CLICKED,
	DRAGGING,
	RELEASED
}

@export var state: State

var cardUI: CardUI

func enter() -> void:
	cardUI.stateLabel.text = str(State.keys()[state])

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
