class_name BattleUI extends CanvasLayer

@export var heroStats: HeroStats

@onready var drawPileButton: CardPileButton = %DrawPileButton
@onready var discardPileButton: CardPileButton = %DiscardPileButton

@onready var drawPileView: CardPileView = %DrawPileView
@onready var discardPileView: CardPileView = %DiscardPileView

func _ready() -> void:
	drawPileButton.pressed.connect(
		drawPileView.showCurrentView.bind("Draw Pile"))
	discardPileButton.pressed.connect(
		discardPileView.showCurrentView.bind("Discard Pile"))

func initializeCardPiles() -> void:
	drawPileButton.cardPile = heroStats.drawPile
	drawPileView.cardPile = heroStats.drawPile
	discardPileButton.cardPile = heroStats.discardPile
	discardPileView.cardPile = heroStats.discardPile
