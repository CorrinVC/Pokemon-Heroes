class_name SummonCreature extends Creature

func performTurn() -> void:
	print_debug(creatureName + " turn performed")
	EventBus.summonActionsCompleted.emit(self)
