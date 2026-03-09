class_name HeroCreature extends Creature

@export var heroStats: HeroStats: set = setHeroStats

func setHeroStats(value: HeroStats) -> void:
	if not value:
		return
	
	heroStats = value.createInstance()
