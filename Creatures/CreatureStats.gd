class_name CreatureStats extends Resource

signal statsChanged

const MAX_SIZE: int = 3

@export_group("Creature Flavor")
@export var creatureName: String
@export var creatureSprite: Texture
@export_range(1, MAX_SIZE, 1) var size: int = MAX_SIZE

@export_group("Battle Stats")
@export var maxHealth: int = 10

var currentHealth: int: set = setHealth
var currentProtect: int: set = setProtect

func setHealth(value: int) -> void:
	currentHealth = value
	statsChanged.emit()

func setProtect(value: int) -> void:
	currentProtect = value
	statsChanged.emit()

func takeDamage(damage: int) -> void:
	currentHealth = clampi(currentHealth - damage, 0, maxHealth)

func createInstance() -> CreatureStats:
	var instance: CreatureStats = self.duplicate()
	instance.currentHealth = maxHealth
	instance.currentProtect = 0
	
	return instance
