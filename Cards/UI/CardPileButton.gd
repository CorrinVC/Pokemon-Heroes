class_name CardPileButton extends Button

@export var cardCountLabel: Label
@export var cardPile: CardPile: set = setCardPile

func setCardPile(value: CardPile) -> void:
	cardPile = value
	if not cardPile.cardPileSizeChanged.is_connected(onCardPileSizeChanged):
		cardPile.cardPileSizeChanged.connect(onCardPileSizeChanged)
		onCardPileSizeChanged(cardPile.cardList.size())

func onCardPileSizeChanged(pileSize: int) -> void:
	if cardCountLabel:
		cardCountLabel.text = "%s" % pileSize
