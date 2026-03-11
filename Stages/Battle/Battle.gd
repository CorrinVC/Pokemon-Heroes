class_name Battle extends Node2D

@onready var heroCreature: HeroCreature = %HeroCreature
@onready var heroLogic: HeroLogic = %HeroLogic
@onready var summonLogic: SummonLogic = %Summons
@onready var enemyLogic: EnemyLogic = %Enemies
@onready var battleUI: BattleUI = %BattleUI

var allyFieldPositions: Dictionary[Vector2, Creature] = {}
var hostileFieldPositions: Dictionary[Vector2, Creature] = {}

func _ready() -> void:
	summonLogic.child_order_changed.connect(onSummonCountChanged.call_deferred)
	enemyLogic.child_order_changed.connect(onEnemyCountChanged.call_deferred)
	
	EventBus.heroTurnEnded.connect(heroLogic.endTurn)
	EventBus.heroHandDiscarded.connect(startSummonTurn)
	EventBus.heroFainted.connect(onHeroFainted)
	
	EventBus.summonTurnEnded.connect(startEnemyTurn)
	
	EventBus.enemyTurnEnded.connect(onEnemyTurnEnded)
	
	EventBus.fieldPositionChanged.connect(updateFieldPositions)
	
	fillFieldPositions()
	startBattle()

func startBattle() -> void:
	battleUI.heroStats = heroCreature.heroStats
	updateFieldPositions()
	
	enemyLogic.resetEnemyActions()
	
	heroLogic.startBattle(heroCreature)
	battleUI.initializeCardPiles()

func startSummonTurn() -> void:
	summonLogic.updateSummonTargets(hostileFieldPositions)
	summonLogic.startTurn()

func onSummonCountChanged() -> void:
	updateFieldPositions()
	enemyLogic.updateEnemyTargets(allyFieldPositions)

func startEnemyTurn() -> void:
	enemyLogic.updateEnemyTargets(allyFieldPositions)
	enemyLogic.startTurn()

func onEnemyTurnEnded() -> void:
	heroLogic.startTurn()
	enemyLogic.resetEnemyActions()

func onEnemyCountChanged() -> void:
	updateFieldPositions()
	summonLogic.updateSummonTargets(hostileFieldPositions)
	if enemyLogic.get_child_count() <= 0:
		EventBus.battleCompleteRequested.emit(BattleCompletePanel.Outcome.WIN)

func onHeroFainted() -> void:
	EventBus.battleCompleteRequested.emit(BattleCompletePanel.Outcome.LOSS)

func updateFieldPositions() -> void:
	for summon: SummonCreature in summonLogic.get_children():
		allyFieldPositions[summon.getFieldPosition()] = summon
	
	allyFieldPositions[heroCreature.getFieldPosition()] = heroCreature
	
	for enemy: EnemyCreature in enemyLogic.get_children():
		hostileFieldPositions[enemy.getFieldPosition()] = enemy

func fillFieldPositions() -> void:
	for column: int in Creature.FieldColumn.values():
		for row: int in Creature.FieldRow.values():
			allyFieldPositions[Vector2(column, row)] = null
			hostileFieldPositions[Vector2(column, row)] = null
