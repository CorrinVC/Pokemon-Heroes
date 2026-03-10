class_name Creature extends Area2D

const BOUNDING_BOX_SIZE: int = 56
const BOUNDING_BOX_OFFSET: int = 28

enum FieldColumn { FRONT, BACK }
enum FieldRow { TOP, CENTER, BOTTOM }

@export var creatureStats: CreatureStats : set = setStats
@export var fieldColumn: FieldColumn
@export var fieldRow: FieldRow

@onready var boundingBox: CollisionShape2D = %BoundingBox
@onready var creatureSprite: Sprite2D = %CreatureSprite

@onready var protectLabel: Label = %ProtectLabel
@onready var healthLabel: Label = %HealthLabel
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
	onStatsChanged()

func onStatsChanged() -> void:
	updateStatLabels()

func updateStatLabels() -> void:
	if creatureStats.currentProtect == 0:
		protectLabel.text = ""
	else:
		protectLabel.text = "(%s)" % creatureStats.currentProtect
	healthLabel.text = "HP: %s/%s" % [creatureStats.currentHealth, creatureStats.maxHealth]

func updateNameLabel() -> void:
	nameLabel.text = "%s" % [creatureName]

func getFieldPosition() -> Vector2:
	return Vector2(fieldColumn, fieldRow)

func onBoundingBoxMouseEntered() -> void:
	nameLabel.show()

func onBoundingBoxMouseExited() -> void:
	nameLabel.hide()
	pass

# Targeting Logic

func findTarget(targets: Dictionary[Vector2, Creature]) -> Creature:
	var target: Creature = searchFieldRow(fieldRow, targets)
	
	if not target:
		var adjacentRows: Array[Creature.FieldRow] = getAdjacentRows()
		
		for row in adjacentRows:
			target = searchFieldRow(row, targets)
			
			if target:
				break
	
	return target

func searchFieldRow(row: Creature.FieldRow, \
	targets: Dictionary[Vector2, Creature]) -> Creature:
	var creatureFound: Creature = null
	
	var frontLinePosition: Vector2 = \
		Vector2(Creature.FieldColumn.FRONT, row)
	var backLinePosition: Vector2 = \
		Vector2(Creature.FieldColumn.BACK, row)
	
	if targets[frontLinePosition]:
		creatureFound = targets[frontLinePosition]
	elif targets[backLinePosition]:
		creatureFound = targets[backLinePosition]
	
	return creatureFound

func getAdjacentRows() -> Array[FieldRow]:
	var adjacentRows: Array[FieldRow] = []
	match fieldRow:
		FieldRow.TOP, FieldRow.BOTTOM:
			adjacentRows = [FieldRow.CENTER]
		FieldRow.CENTER:
			adjacentRows = [FieldRow.TOP, FieldRow.BOTTOM]
	
	return adjacentRows
