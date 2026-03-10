class_name SummonLogic extends Node2D

var actingSummons: Array[SummonCreature] = []

func _ready() -> void:
	EventBus.heroHandDrawn.connect(generateSummonsEnergy)
	EventBus.summonActionsCompleted.connect(onSummonActionsCompleted)

func updateSummonTargets(enemies: Dictionary[Vector2, Creature]) -> void:
	for summon: SummonCreature in get_children():
		summon.setTarget(summon.findTarget(enemies))

func generateSummonsEnergy() -> void:
	var energyGenerated: int = 0
	for summon: SummonCreature in get_children():
		energyGenerated += summon.creatureStats.energyPerTurn
	EventBus.summonEnergyGenerated.emit(energyGenerated)

func startTurn() -> void:
	if get_child_count() == 0:
		return
	
	actingSummons.clear()
	for summon: SummonCreature in get_children():
		summon.creatureStats.currentProtect = 0
		actingSummons.append(summon)
	
	startNextSummonTurn()

func startNextSummonTurn() -> void:
	if actingSummons.is_empty():
		EventBus.summonTurnEnded.emit()
		return
	
	await get_tree().create_timer(0.25).timeout
	
	actingSummons[0].performTurn()

func onSummonActionsCompleted(summon: SummonCreature) -> void:
	actingSummons.erase(summon)
	startNextSummonTurn()
