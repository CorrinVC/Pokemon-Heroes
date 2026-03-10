class_name EnemyLogic extends Node2D

#var CREATURE_SCENE: PackedScene = preload("uid://cpa7jsu7bnwhu")

var actingEnemies: Array[EnemyCreature] = []

func _ready() -> void:
	EventBus.enemyActionCompleted.connect(onEnemyActionCompleted)

func startTurn() -> void:
	if get_child_count() == 0:
		return
	
	actingEnemies.clear()
	for enemy: EnemyCreature in get_children():
		enemy.creatureStats.currentProtect = 0
		actingEnemies.append(enemy)
	
	startNextEnemyTurn()

func startNextEnemyTurn() -> void:
	if actingEnemies.is_empty():
		EventBus.enemyTurnEnded.emit()
		return
	
	await get_tree().create_timer(0.25).timeout
	
	actingEnemies[0].performTurn()

func onEnemyActionCompleted(enemy: EnemyCreature) -> void:
	actingEnemies.erase(enemy)
	startNextEnemyTurn()
