class_name HeroLogic extends Node

var heroCreature: HeroCreature

var creatureStats: CreatureStats
var heroStats: HeroStats

func _ready() -> void:
	EventBus.cardPlayed.connect(onCardPlayed)
	

func startBattle(hero: HeroCreature) -> void:
	heroCreature = hero
	
	creatureStats = heroCreature.creatureStats
	heroStats = heroCreature.heroStats
	
	heroStats.drawPile = heroStats.deck.duplicate(true)
	heroStats.drawPile.shuffle()
	heroStats.discardPile = CardPile.new()

func onCardPlayed(cardData: CardData) -> void:
	heroStats.discardPile.addCard(cardData)
	creatureStats.energyCount -= cardData.energyCost
