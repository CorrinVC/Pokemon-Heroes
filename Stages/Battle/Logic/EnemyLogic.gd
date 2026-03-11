class_name EnemyLogic extends Node2D

#var CREATURE_SCENE: PackedScene = preload("uid://cpa7jsu7bnwhu")

var actingEnemies: Array[EnemyCreature] = []

func _ready() -> void:
	EventBus.enemyActionCompleted.connect(onEnemyActionCompleted)
	EventBus.enemyFainted.connect(onEnemyFainted)

func updateEnemyTargets(allies: Dictionary[Vector2, Creature]) -> void:
	for enemy: EnemyCreature in get_children():
		enemy.setTarget(enemy.findTarget(allies))

func startTurn() -> void:
	actingEnemies.clear()
	for enemy: EnemyCreature in get_children():
		enemy.creatureStats.currentProtect = 0
		actingEnemies.append(enemy)
	
	startNextEnemyTurn()

func startNextEnemyTurn() -> void:
	await get_tree().create_timer(0.25).timeout
	
	if actingEnemies.is_empty():
		EventBus.enemyTurnEnded.emit()
		return
	
	actingEnemies[0].performTurn()

func onEnemyActionCompleted(enemy: EnemyCreature) -> void:
	actingEnemies.erase(enemy)
	startNextEnemyTurn()

func onEnemyFainted(enemy: EnemyCreature) -> void:
	var isEnemyTurn: bool = actingEnemies.size() > 0
	actingEnemies.erase(enemy)
	
	if isEnemyTurn:
		startNextEnemyTurn()

func resetEnemyActions() -> void:
	for enemy: EnemyCreature in get_children():
		enemy.currentAction = null
		enemy.intentUI.show()
		enemy.updateAction()
