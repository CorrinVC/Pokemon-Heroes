class_name Creature extends Area2D

const BOUNDING_BOX_SIZE: int = 56
const BOUNDING_BOX_OFFSET: int = 28

@export var creatureStats: CreatureStats : set = setStats

@onready var boundingBox: CollisionShape2D = %BoundingBox
@onready var creatureSprite: Sprite2D = %CreatureSprite
@onready var nameLabel: Label = %NameLabel

var creatureName: String

func setStats(value: CreatureStats) -> void:
	if not value:
		return
	
	if not is_node_ready():
		await ready
	
	creatureStats = value.createInstance()
	creatureStats.statsChanged.connect(onStatsChanged)
	
	var boundingBoxShape: RectangleShape2D = boundingBox.shape.duplicate() as RectangleShape2D
	boundingBoxShape.size = Vector2.ONE * (BOUNDING_BOX_SIZE * creatureStats.size)
	boundingBox.shape = boundingBoxShape
	boundingBox.position.y = BOUNDING_BOX_OFFSET * (CreatureStats.MAX_SIZE - creatureStats.size)
	
	creatureSprite.texture = creatureStats.creatureSprite
	creatureName = creatureStats.creatureName
	updateNameLabel()

func onStatsChanged() -> void:
	updateNameLabel()

func updateNameLabel() -> void:
	nameLabel.text = "%s: %s" % [creatureName, creatureStats.currentHealth]

func onBoundingBoxMouseEntered() -> void:
	nameLabel.show()

func onBoundingBoxMouseExited() -> void:
	nameLabel.hide()
	pass
