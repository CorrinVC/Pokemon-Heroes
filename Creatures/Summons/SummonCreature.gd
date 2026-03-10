class_name SummonCreature extends Creature

@export var summonStats: SummonStats : set = setSummonStats

var actions: Array[SummonAction] = []
var selectedAction: SummonAction
var actionManuallySelected: bool = false

func setSummonStats(value: SummonStats) -> void:
	if not value:
		return
	
	summonStats = value.createInstance()
	actions = summonStats.actions.duplicate()
	for action in actions:
		if action:
			action.summon = self

func setTarget(creature: Creature) -> void:
	for action in actions:
		action.target = creature

func selectAction() -> void:
	for action in actions:
		if creatureStats.energyCount >= action.energyCost:
			selectedAction = action

func performTurn() -> void:
	if not actionManuallySelected:
		selectAction()
	
	if not selectedAction:
		print_debug(creatureName + " has no Selected Action")
		EventBus.summonActionsCompleted.emit(self)
	
	selectedAction.performAction()
