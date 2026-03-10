class_name SummonAction extends Resource

@export var id: String
@export var energyCost: int = 0

var summon: SummonCreature
var target: Creature

func performAction() -> void:
	EventBus.summonActionsCompleted.emit(summon)
	print_debug(summon.creatureName + " performing " + id)
