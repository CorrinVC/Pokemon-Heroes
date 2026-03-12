class_name EnergyIconState extends Node

signal transitionRequested(from: EnergyIconState, to: State)

const UI_LAYER_GROUP: String = "uiLayer"

enum State{
	SINGLE,
	STACKED,
	CLICKED,
	DRAGGING,
	RELEASED
}

@export var state: State

var energyIcon: EnergyIcon

func enter() -> void:
	pass

func exit() -> void:
	pass

func onInput(_event: InputEvent) -> void:
	pass

func onGuiInput(_event: InputEvent) -> void:
	pass 
