class_name Battle extends Node2D

@onready var heroCreature: HeroCreature = %HeroCreature
@onready var heroLogic: HeroLogic = %HeroLogic
@onready var summonLogic: SummonLogic = %Summons
@onready var enemyLogic: EnemyLogic = %Enemies
@onready var battleUI: BattleUI = %BattleUI

func _ready() -> void:
	EventBus.heroTurnEnded.connect(heroLogic.endTurn)
	EventBus.heroHandDiscarded.connect(summonLogic.startTurn)
	
	EventBus.summonTurnEnded.connect(enemyLogic.startTurn)
	
	EventBus.enemyTurnEnded.connect(onEnemyTurnEnded)
	
	startBattle()

func startBattle() -> void:
	battleUI.heroStats = heroCreature.heroStats
	heroLogic.startBattle(heroCreature)
	battleUI.initializeCardPiles()

func onEnemyTurnEnded() -> void:
	heroLogic.startTurn()
