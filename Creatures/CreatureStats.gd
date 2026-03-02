class_name CreatureStats extends Resource

signal statsChanged

const MAX_SIZE: int = 3

@export var creatureName: String
@export var creatureSprite: Texture
@export var maxHealth: int = 10
@export_range(1, MAX_SIZE, 1) var size: int = MAX_SIZE

var currentHealth: int = maxHealth

func takeDamage(damage: int) -> void:
	currentHealth = clampi(currentHealth - damage, 0, maxHealth)
	
	statsChanged.emit()
