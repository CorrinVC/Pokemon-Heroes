class_name BattleUI extends CanvasLayer

@export var heroStats: HeroStats

@onready var drawPileButton: CardPileButton = %DrawPileButton
@onready var discardPileButton: CardPileButton = %DiscardPileButton

func initializeCardPiles() -> void:
	drawPileButton.cardPile = heroStats.drawPile
	discardPileButton.cardPile = heroStats.discardPile
