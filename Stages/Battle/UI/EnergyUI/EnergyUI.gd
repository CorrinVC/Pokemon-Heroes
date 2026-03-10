class_name EnergyUI extends TextureRect

@export var creatureStats: CreatureStats: set = setCreatureStats

@onready var energyCountLabel: Label = %EnergyCountLabel

func setCreatureStats(value: CreatureStats) -> void:
	creatureStats = value
	
	if not creatureStats.statsChanged.is_connected(onStatsChanged):
		creatureStats.statsChanged.connect(onStatsChanged)
	
	if not is_node_ready():
		await ready
	onStatsChanged()

func onStatsChanged() -> void:
	energyCountLabel.text = "%s" % creatureStats.energyCount
