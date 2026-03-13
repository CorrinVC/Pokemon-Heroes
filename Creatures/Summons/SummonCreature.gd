class_name SummonCreature extends Creature

const ENERGY_ICON_SCENE: PackedScene = preload("uid://c06icat81v5ic")
const MAX_SINGLE_ICONS: int = 3

@export var summonStats: SummonStats : set = setSummonStats

var actions: Array[SummonAction] = []
var selectedAction: SummonAction
var actionManuallySelected: bool = false

var summonEnergyUI: Control
var lastEnergyCount: int = 0

func _ready() -> void:
	summonEnergyUI = Control.new()
	add_child(summonEnergyUI)

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

func takeDamage(damage: int, factorProtect: bool = true) -> void:
	super.takeDamage(damage, factorProtect)
	if creatureStats.currentHealth <= 0:
		EventBus.summonFainted.emit(self)
		queue_free()

func onStatsChanged() -> void:
	super.onStatsChanged()
	if creatureStats.energyCount != lastEnergyCount:
		for energyIcon: EnergyIcon in summonEnergyUI.get_children():
			energyIcon.queue_free()
		
		if creatureStats.energyCount <= MAX_SINGLE_ICONS:
			for i in range(creatureStats.energyCount):
				summonEnergyUI.add_child(createEnergyIcon(i))
		else:
			var newEnergyIcon := createEnergyIcon(0, true)
			summonEnergyUI.add_child(newEnergyIcon)
			newEnergyIcon.setAmount(creatureStats.energyCount)

func createEnergyIcon(index: int = 0, stacked: bool = false) -> EnergyIcon:
	var newEnergyIcon: EnergyIcon = ENERGY_ICON_SCENE.instantiate() as EnergyIcon
	newEnergyIcon.stacked = stacked
	newEnergyIcon.interactable = false
	newEnergyIcon.setEnergyType(creatureStats.energyType)
	
	var iconXPosition: float = index * (newEnergyIcon.size.x + MAX_SINGLE_ICONS)
	iconXPosition -= (creatureSprite.texture.get_size().x / 2) * \
						creatureStats.size
	var iconYPosition: float = creatureSprite.texture.get_size().y
	var iconPosition: Vector2 = Vector2(iconXPosition, iconYPosition)
	newEnergyIcon.position = iconPosition
	
	return newEnergyIcon
