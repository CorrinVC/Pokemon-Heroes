extends CardData

func playCard(targets: Array[Area2D]) -> void:
	var pikachuCreatureStats: CreatureStats = load("uid://bwoe4wghimy6p")
	var pikachuSummonStats: SummonStats = load("uid://c43puoqpmc3f")
	
	EventBus.summonCardPlayed.emit(pikachuCreatureStats, pikachuSummonStats)
	
	super.playCard(targets)
