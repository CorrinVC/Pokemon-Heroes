class_name EnemyCreature extends Creature

func performTurn() -> void:
	print_debug(creatureName + " turn performed")
	EventBus.enemyActionCompleted.emit(self)
