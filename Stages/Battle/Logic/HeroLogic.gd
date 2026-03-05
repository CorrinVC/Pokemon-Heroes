class_name HeroLogic extends Node

var heroStats: HeroStats

func _ready() -> void:
	EventBus.cardPlayed.connect(onCardPlayed)

func startBattle(stats: HeroStats) -> void:
	heroStats = stats
	heroStats.drawPile = heroStats.deck.duplicate(true)
	heroStats.drawPile.shuffle()
	heroStats.discardPile = CardPile.new()

func onCardPlayed(cardData: CardData) -> void:
	heroStats.discardPile.addCard(cardData)
