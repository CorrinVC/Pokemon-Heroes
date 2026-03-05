class_name HeroLogic extends Node

var heroStats: HeroStats

func startBattle(stats: HeroStats) -> void:
	heroStats = stats
	heroStats.drawPile = heroStats.deck.duplicate(true)
	heroStats.drawPile.shuffle()
	heroStats.discardPile = CardPile.new()
