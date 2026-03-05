class_name Battle extends Node2D

@onready var heroCreature: HeroCreature = %HeroCreature
@onready var heroLogic: HeroLogic = %HeroLogic
@onready var battleUI: BattleUI = %BattleUI

func _ready() -> void:
	startBattle()

func startBattle() -> void:
	battleUI.heroStats = heroCreature.heroStats
	heroLogic.startBattle(heroCreature.heroStats)
	battleUI.initializeCardPiles()
	
