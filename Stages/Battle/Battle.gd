class_name Battle extends Node2D

@onready var heroCreature: HeroCreature = %HeroCreature
@onready var heroLogic: HeroLogic = %HeroLogic
@onready var summonLogic: SummonLogic = %Summons
@onready var enemyLogic: EnemyLogic = %Enemies
@onready var battleUI: BattleUI = %BattleUI

var allyFieldPositions: Dictionary[Vector2, Creature] = {}
var hostileFieldPositions: Dictionary[Vector2, Creature] = {}

func _ready() -> void:
	EventBus.heroTurnEnded.connect(heroLogic.endTurn)
	EventBus.heroHandDiscarded.connect(startSummonTurn)
	
	EventBus.summonTurnEnded.connect(startEnemyTurn)
	
	EventBus.enemyTurnEnded.connect(onEnemyTurnEnded)
	
	EventBus.fieldPositionChanged.connect(updateFieldPositions)
	
	fillFieldPositions()
	startBattle()

func startBattle() -> void:
	battleUI.heroStats = heroCreature.heroStats
	updateFieldPositions()
	
	heroLogic.startBattle(heroCreature)
	battleUI.initializeCardPiles()

func startSummonTurn() -> void:
	summonLogic.updateSummonTargets(hostileFieldPositions)
	summonLogic.startTurn()

func startEnemyTurn() -> void:
	enemyLogic.updateEnemyTargets(allyFieldPositions)
	enemyLogic.startTurn()

func onEnemyTurnEnded() -> void:
	heroLogic.startTurn()

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
