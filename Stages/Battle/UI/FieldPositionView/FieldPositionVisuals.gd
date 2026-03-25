@tool
extends CenterContainer

@export var creatureStats: CreatureStats : set = setCreatureStats

@onready var creatureTexture: TextureRect = %CreatureTexture

func setCreatureStats(value: CreatureStats) -> void:
	if not value:
		return
	
	if not is_node_ready():
		await ready
	
	creatureStats = value
	
	creatureTexture.texture = creatureStats.creatureSprite
	creatureTexture.scale = Vector2.ONE * creatureStats.size
