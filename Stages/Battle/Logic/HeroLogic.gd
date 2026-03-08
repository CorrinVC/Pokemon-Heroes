class_name HeroLogic extends Node

const CARD_DRAW_INTERVAL: float = 0.15
const CARD_DISCARD_INTERVAL: float = 0.25

@export var hand: Hand

var heroCreature: HeroCreature

var creatureStats: CreatureStats
var heroStats: HeroStats

func _ready() -> void:
	EventBus.cardPlayed.connect(onCardPlayed)
	EventBus.heroTurnEnded.connect(endTurn)

func startBattle(hero: HeroCreature) -> void:
	heroCreature = hero
	
	creatureStats = heroCreature.creatureStats
	heroStats = heroCreature.heroStats
	
	heroStats.drawPile = heroStats.deck.duplicate(true)
	heroStats.drawPile.shuffle()
	heroStats.discardPile = CardPile.new()
	
	startTurn()

func onCardPlayed(cardData: CardData) -> void:
	heroStats.discardPile.addCard(cardData)
	creatureStats.energyCount -= cardData.energyCost

func startTurn() -> void:
	if creatureStats.currentHealth <= 0:
		return
	
	creatureStats.currentProtect = 0
	creatureStats.energyCount = creatureStats.energyPerTurn
	drawHand(heroStats.cardsPerTurn)

func drawHand(cardCount: int) -> void:
	var tween: Tween = create_tween()
	tween.tween_interval(CARD_DRAW_INTERVAL * 4)
	for i in range(cardCount):
		tween.tween_callback(drawCard)
		tween.tween_interval(CARD_DRAW_INTERVAL)

func drawCard() -> void:
	reshuffleDeckFromDiscard()
	hand.addCard(heroStats.drawPile.drawCard())
	reshuffleDeckFromDiscard()

func reshuffleDeckFromDiscard() -> void:
	if not heroStats.drawPile.isEmpty():
		return
	
	while not heroStats.discardPile.isEmpty():
		heroStats.drawPile.addCard(heroStats.discardPile.drawCard())
	
	heroStats.drawPile.shuffle()

func endTurn() -> void:
	discardHand()

func discardHand() -> void:
	if hand.get_child_count() <= 0:
		return
	
	var tween: Tween = create_tween()
	for child in hand.get_children():
		if child is BattleCard:
			var battleCard: BattleCard = child as BattleCard
			tween.tween_callback(heroStats.discardPile.addCard.bind(battleCard.cardData))
			tween.tween_callback(hand.discardCard.bind(battleCard))
			tween.tween_interval(CARD_DISCARD_INTERVAL)
	tween.tween_interval(CARD_DISCARD_INTERVAL)
	
	tween.finished.connect(EventBus.heroHandDiscarded.emit)
