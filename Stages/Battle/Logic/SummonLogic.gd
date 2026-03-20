class_name SummonLogic extends Node2D

var CREATURE_SCENE: PackedScene = preload("uid://cpa7jsu7bnwhu")
var SUMMON_SCRIPT: Script = preload("uid://b821cttcvijqf")

var actingSummons: Array[SummonCreature] = []

func _ready() -> void:
	EventBus.summonCardPlayed.connect(onCreatureSummoned.call_deferred)
	EventBus.heroHandDrawn.connect(generateSummonsEnergy)
	EventBus.summonActionsCompleted.connect(onSummonActionsCompleted)
	EventBus.summonFainted.connect(onSummonFainted)

func updateSummonTargets(enemies: Dictionary[Vector2, Creature]) -> void:
	for summon: SummonCreature in get_children():
		summon.setTarget(summon.findTarget(enemies))

func generateSummonsEnergy() -> void:
	var energyGenerated: int = 0
	for summon: SummonCreature in get_children():
		energyGenerated += summon.creatureStats.energyPerTurn
	EventBus.summonEnergyGenerated.emit(energyGenerated)

func startTurn() -> void:
	actingSummons.clear()
	for summon: SummonCreature in get_children():
		summon.creatureStats.currentProtect = 0
		actingSummons.append(summon)
	
	startNextSummonTurn()

func startNextSummonTurn() -> void:
	await get_tree().create_timer(0.25).timeout
	
	if actingSummons.is_empty():
		EventBus.summonTurnEnded.emit()
		return
	
	actingSummons[0].performTurn()

func onSummonActionsCompleted(summon: SummonCreature) -> void:
	actingSummons.erase(summon)
	startNextSummonTurn()

func onSummonFainted(summon: SummonCreature) -> void:
	var isSummonTurn: bool = actingSummons.size() > 0
	actingSummons.erase(summon)
	
	if isSummonTurn:
		startNextSummonTurn()

func onCreatureSummoned(creatureStats: CreatureStats, summonStats: SummonStats) -> void:
	var newCreature := CREATURE_SCENE.instantiate()
	newCreature.set_script(SUMMON_SCRIPT)
	
	var newSummon: SummonCreature = newCreature as SummonCreature
	newSummon.creatureStats = creatureStats
	newSummon.summonStats = summonStats
	add_child(newSummon)
	
