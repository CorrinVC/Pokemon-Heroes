class_name CardData extends Resource

enum Target {
	SINGLE,
	SINGLE_FRIENDLY,
	SINGLE_HOSTILE,
	ALL_FRIENDLY,
	ALL_HOSTILE
}

@export var cardName: String
@export var cardArt: Texture
@export var cardType: CardTypes.CardType
@export var energyType: CardTypes.EnergyType
@export var rarity: CardTypes.Rarity
@export var energyCost: int
@export var target: Target
@export_multiline var cardText: String

func playCard(_targets: Array[Node2D]) -> void:
	print("Playing " + cardName)

func isSingleTargeted() -> bool:
	return target == Target.SINGLE or target == Target.SINGLE_FRIENDLY \
		or target == Target.SINGLE_HOSTILE
