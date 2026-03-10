class_name SummonAction extends Resource

@export var id: String
@export var energyCost: int = 0

var summon: SummonCreature
var target: Creature

func performAction() -> void:
	EventBus.summonActionsCompleted.emit(summon)
	var targetName: String = "No Target" if not target else target.creatureName
	print_debug(summon.creatureName + " performing " + id + " on " + targetName)
