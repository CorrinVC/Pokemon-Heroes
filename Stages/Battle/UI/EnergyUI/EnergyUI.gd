class_name EnergyUI extends Control

const ENERGY_ICON_SCENE: PackedScene = preload("uid://c06icat81v5ic")
const MAX_SINGLE_ICONS: int = 4

@export var creatureStats: CreatureStats: set = setCreatureStats

var interactable: bool = false : set = setInteractable

func _ready() -> void:
	for icon: EnergyIcon in get_children():
		icon.queue_free()
	
	EventBus.heroHandDrawn.connect(setInteractable.bind(true))
	EventBus.heroTurnEnded.connect(setInteractable.bind(false))
	
	child_order_changed.connect(energyCountChanged)

func setCreatureStats(value: CreatureStats) -> void:
	creatureStats = value
	
	if not creatureStats.statsChanged.is_connected(onStatsChanged):
		creatureStats.statsChanged.connect(onStatsChanged)
	
	if not is_node_ready():
		await ready
	onStatsChanged()

func setInteractable(value: bool) -> void:
	interactable = value
	
	for icon: EnergyIcon in get_children():
		icon.interactable = interactable

func onStatsChanged() -> void:
	if creatureStats.energyCount > MAX_SINGLE_ICONS:
		for i in range(get_child_count()):
			var deleteIcon: EnergyIcon = get_child(i)
			deleteIcon.queue_free()
		
		createEnergyIcon(creatureStats.energyType, true)
	
	else:
		if get_child_count() == creatureStats.energyCount:
			return
		
		if get_child_count() == 1 and creatureStats.energyCount == MAX_SINGLE_ICONS:
			remove_child(get_child(0))
		
		while creatureStats.energyCount > get_child_count():
			createEnergyIcon(creatureStats.energyType, false)
		
		while get_child_count() > creatureStats.energyCount:
			remove_child(get_children()[-1])

func onEnergyIconReparentRequested(energyIcon: EnergyIcon) -> void:
	if energyIcon in get_children():
		return
	
	energyIcon.reparent(self)

func createEnergyIcon(type: CardTypes.EnergyType, stacked: bool) -> void:
	var newEnergyIcon: EnergyIcon = \
		ENERGY_ICON_SCENE.instantiate() as EnergyIcon
	newEnergyIcon.stacked = stacked
	
	if not stacked:
		newEnergyIcon.position = getNewIconPosition(get_child_count(), newEnergyIcon)
	
	add_child(newEnergyIcon)
	
	newEnergyIcon.creatureStats = creatureStats
	newEnergyIcon.setEnergyType(type)
	newEnergyIcon.reparentRequested.connect(onEnergyIconReparentRequested)
	newEnergyIcon.interactable = interactable
	
	if stacked:
		newEnergyIcon.setAmount(creatureStats.energyCount)

func energyCountChanged() -> void:
	for i in range(get_child_count()):
		var icon: EnergyIcon = get_child(i)
		
		var tween: Tween = create_tween()
		tween.set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
		tween.tween_property(icon, "position", \
			getNewIconPosition(i, icon), icon.MOVE_TIMER)

func getNewIconPosition(index: int, icon: EnergyIcon) -> Vector2:
	var separation: int = 4
	var newXPosition: float = (icon.size.x + separation) * index
	var newPosition: Vector2 = Vector2(newXPosition, 0.0)
	
	return newPosition
