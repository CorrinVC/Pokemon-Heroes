class_name SummonLogic extends Node2D

var actingSummons: Array[SummonCreature] = []

func _ready() -> void:
	EventBus.summonActionsCompleted.connect(onSummonActionsCompleted)

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
	
	actingSummons[0].performTurn()

func onSummonActionsCompleted(summon: SummonCreature) -> void:
	actingSummons.erase(summon)
	startNextSummonTurn()
