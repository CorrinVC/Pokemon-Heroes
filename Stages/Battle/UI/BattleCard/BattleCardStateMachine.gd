class_name BattleCardStateMachine extends Node

@export var initialState: CardState

var currentState: CardState
var states: Dictionary = {}

func initStateMachine(battleCard: BattleCard) -> void:
	for state: CardState in get_children():
		states[state.state] = state
		state.transitionRequested.connect(onTransitionRequested)
		state.battleCard = battleCard
	
	if initialState:
		initialState.enter()
		currentState = initialState

func onTransitionRequested(from: CardState, to: CardState.State) -> void:
	assert(from == currentState, "Requesting Transition From Non Current Card State")
	
	var newState: CardState = states[to]
	assert(newState, "Requesting Transition To Non Existent Card State")
	
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

func onMouseEntered() -> void:
	if currentState:
		currentState.onMouseEntered()

func onMouseExited() -> void:
	if currentState:
		currentState.onMouseExited()
