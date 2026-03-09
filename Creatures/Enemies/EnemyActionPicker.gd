class_name EnemyActionPicker extends Node

@export var enemy: EnemyCreature: set = setEnemy
@export var target: Creature: set = setTarget

@onready var totalWeight: float = 0.0

func setEnemy(value: EnemyCreature) -> void:
	enemy = value
	
	for enemyAction: EnemyAction in get_children():
		enemyAction.enemy = enemy
	
	updateActionWeights()

func setTarget(value: Creature) -> void:
	target = value
	
	for enemyAction: EnemyAction in get_children():
		enemyAction.target = target

func updateActionWeights() -> void:
	totalWeight = 0.0
	for action: EnemyAction in get_children():
		if not action or not action.isPerformable() or not action.isChanceBased:
			continue
		
		totalWeight += action.chanceWeight
		action.accumulatedWeight = totalWeight

func getAction() -> EnemyAction:
	updateActionWeights()
	
	var newAction: EnemyAction = checkForConditionalActions()
	if not newAction:
		newAction = getChanceBasedAction()
	
	return newAction

func checkForConditionalActions() -> EnemyAction:
	var conditionalAction: EnemyAction = null
	
	for action: EnemyAction in get_children():
		if not action or action.isChanceBased:
			continue
		
		if action.isPerformable():
			conditionalAction = action
	
	return conditionalAction

func getChanceBasedAction() -> EnemyAction:
	var chanceBasedAction: EnemyAction = null
	var roll: float = RNG.instance.randf_range(0.0, totalWeight)
	
	for action: EnemyAction in get_children():
		if not action or not action.isChanceBased:
			continue
		
		if action.accumulatedWeight > roll:
			chanceBasedAction = action
			break
	
	return chanceBasedAction
