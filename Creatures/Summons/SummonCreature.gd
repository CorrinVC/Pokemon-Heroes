class_name SummonCreature extends Creature

@export var summonStats: SummonStats

func performTurn() -> void:
	print_debug(creatureName + " turn performed")
	EventBus.summonActionsCompleted.emit(self)
