class_name HeroCreature extends Creature

@export var heroStats: HeroStats: set = setHeroStats

func setHeroStats(value: HeroStats) -> void:
	if not value:
		return
	
	if not is_node_ready():
		await ready
	
	heroStats = value.createInstance()
