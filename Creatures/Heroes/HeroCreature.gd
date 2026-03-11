class_name HeroCreature extends Creature

@export var heroStats: HeroStats: set = setHeroStats

func setHeroStats(value: HeroStats) -> void:
	if not value:
		return
	
	heroStats = value.createInstance()

func takeDamage(damage: int, factorProtect: bool = true) -> void:
	super.takeDamage(damage, factorProtect)
	if creatureStats.currentHealth <= 0:
		EventBus.heroFainted.emit()
		queue_free()
