class_name HeroStats extends Resource

@export var startingDeck: CardPile
@export var cardsPerTurn: int = 5

var deck: CardPile
var drawPile: CardPile
var discardPile: CardPile

func createInstance() -> HeroStats:
	var instance: HeroStats = self.duplicate()
	instance.deck = instance.startingDeck.duplicate()
	instance.drawPile = CardPile.new()
	instance.discardPile = CardPile.new()
	
	return instance
