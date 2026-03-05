class_name CardPileView extends Control

const CARD_VISUALS_SCENE = preload("uid://by5cs38ga7csu")

@export var cardPile: CardPile

@onready var cardPileTitle: Label = %CardPileTitle
@onready var cardGridContainer: GridContainer = %CardGridContainer
@onready var backButton: Button = %BackButton

func _ready() -> void:
	backButton.pressed.connect(hide)
	clearCardGrid()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(InputActions.CANCEL):
		hide()

func clearCardGrid() -> void:
	for card in cardGridContainer.get_children():
		card.queue_free()

func showCurrentView(title: String, sorted: bool = false) -> void:
	clearCardGrid()
	
	cardPileTitle.text = title
	updateView.call_deferred(sorted)

func updateView(sorted: bool) -> void:
	if not cardPile:
		return
	
	var allCards: Array[CardData] = cardPile.cardList.duplicate()
	# TODO
	if sorted:
		pass
	
	for card in allCards:
		var newCard: CardVisuals = CARD_VISUALS_SCENE.instantiate() as CardVisuals
		cardGridContainer.add_child(newCard)
		newCard.cardData = card
	
	show()
