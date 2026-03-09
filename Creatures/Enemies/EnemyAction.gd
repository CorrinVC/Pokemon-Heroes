class_name EnemyAction extends Node

@export var id: String
@export var energyCost: int = 0
@export var isChanceBased: bool = true
@export_range(0.0, 10.0) var chanceWeight: float = 1.0

@onready var accumulatedWeight: float = 0.0

var enemy: EnemyCreature
var target: Creature

func isPerformable() -> bool:
	return energyCost <= enemy.creatureStats.energyCount

func performAction() -> void:
	EventBus.enemyActionCompleted.emit(enemy)
	print_debug(enemy.creatureName + " performing " + id)
