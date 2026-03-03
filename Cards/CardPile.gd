class_name CardPile extends Resource

signal cardPileSizeChanged(pileSize: int)

@export var cardList: Array[CardData] = []

func isEmpty() -> bool:
	return cardList.is_empty()

func drawCard() -> CardData:
	var cardData: CardData = cardList.pop_front()
	cardPileSizeChanged.emit(cardList.size())
	return cardData

func addCard(cardData: CardData) -> void:
	cardList.append(cardData)
	cardPileSizeChanged.emit(cardList.size())

func shuffle() -> void:
	RNG.arrayShuffle(cardList)

func clear() -> void:
	cardList.clear()
	cardPileSizeChanged.emit(cardList.size())

func _to_string() -> String:
	var cardStrings: PackedStringArray = []
	for i in range(cardList.size()):
		cardStrings.append(cardList[i].cardName)
	
	return "\n".join(cardStrings)
