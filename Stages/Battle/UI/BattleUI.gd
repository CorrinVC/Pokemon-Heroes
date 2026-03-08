class_name BattleUI extends CanvasLayer

@export var heroCreature: HeroCreature: set = setHero

@onready var energyUI: EnergyUI = %EnergyUI
@onready var drawPileButton: CardPileButton = %DrawPileButton
@onready var discardPileButton: CardPileButton = %DiscardPileButton
@onready var endTurnButton: Button = %EndTurnButton

@onready var drawPileView: CardPileView = %DrawPileView
@onready var discardPileView: CardPileView = %DiscardPileView

var creatureStats: CreatureStats
var heroStats: HeroStats

func _ready() -> void:
	drawPileButton.pressed.connect(
		drawPileView.showCurrentView.bind("Draw Pile"))
	discardPileButton.pressed.connect(
		discardPileView.showCurrentView.bind("Discard Pile"))
	endTurnButton.pressed.connect(EventBus.heroTurnEnded.emit)

func setHero(value: HeroCreature) -> void:
	heroCreature = value
	
	if not is_node_ready():
		await ready
	
	creatureStats = heroCreature.creatureStats
	heroStats = heroCreature.heroStats
	energyUI.creatureStats = creatureStats

func initializeCardPiles() -> void:
	drawPileButton.cardPile = heroStats.drawPile
	drawPileView.cardPile = heroStats.drawPile
	discardPileButton.cardPile = heroStats.discardPile
	discardPileView.cardPile = heroStats.discardPile
