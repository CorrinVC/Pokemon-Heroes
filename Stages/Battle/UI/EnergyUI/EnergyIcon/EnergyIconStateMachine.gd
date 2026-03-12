class_name EnergyIconStateMachine extends Node

@export var initialState: EnergyIconState

var currentState: EnergyIconState
var states: Dictionary = {}

func initStateMachine(energyIcon: EnergyIcon) -> void:
	for iconState: EnergyIconState in get_children():
		states[iconState.state] = iconState
		iconState.transitionRequested.connect(onTransitionRequested)
		iconState.energyIcon = energyIcon
	
	initialState = states[EnergyIconState.State.STACKED] if energyIcon.stacked \
		else states[EnergyIconState.State.SINGLE]
	
	if initialState:
		initialState.enter()
		currentState = initialState

func onTransitionRequested(from: EnergyIconState, to: EnergyIconState.State) -> void:
	assert(from == currentState, "Requesting Transition From Non Current Icon State")
	
	var newState: EnergyIconState = states[to]
	assert(newState, "Requesting Transition To Non Existent Icon State")
	
	if currentState:
		currentState.exit()
	
	newState.enter()
	currentState = newState

func onInput(event: InputEvent) -> void:
	if currentState:
		currentState.onInput(event)

func onGuiInput(event: InputEvent) -> void:
	if currentState:
		currentState.onGuiInput(event)
