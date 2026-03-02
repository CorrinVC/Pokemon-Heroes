@tool
class_name CardVisuals extends Control

const ENERGY_COLORS: Dictionary = {
	CardTypes.EnergyType.GRASS: Color.FOREST_GREEN,
	CardTypes.EnergyType.FIRE: Color.ORANGE_RED,
	CardTypes.EnergyType.WATER: Color.DODGER_BLUE,
	CardTypes.EnergyType.ELECTRIC: Color.YELLOW,
	CardTypes.EnergyType.COLORLESS: Color.LIGHT_GRAY
}

const RARITY_COLORS: Dictionary = {
	CardTypes.Rarity.COMMON: Color.DARK_SLATE_GRAY,
	CardTypes.Rarity.UNCOMMON: Color.MEDIUM_BLUE,
	CardTypes.Rarity.RARE: Color.DARK_RED,
	CardTypes.Rarity.LEGENDARY: Color.GOLDENROD
}

@export var cardData: CardData : set = setCardData

@onready var background: Panel = %Background
@onready var nameLabel: Label = %CardNameLabel
@onready var cardArt: TextureRect = %CardArt
@onready var cardTypeLabel: Label = %CardTypeLabel
@onready var cardTextLabel: Label = %CardTextLabel

func setCardData(value: CardData) -> void:
	if not is_node_ready():
		await ready
	
	if not value:
		return
	
	cardData = value
	
	setBackgroundColor()
	nameLabel.text = cardData.cardName
	cardArt.texture = cardData.cardArt
	cardTypeLabel.text = str(CardTypes.CardType.keys()[cardData.cardType])
	cardTextLabel.text = cardData.cardText

func setBackgroundColor() -> void:
	var panelStyleBox: StyleBoxFlat = background.get_theme_stylebox("panel") as StyleBoxFlat
	var backgroundColor: Color = ENERGY_COLORS[cardData.energyType]
	var borderColor: Color = RARITY_COLORS[cardData.rarity]
	backgroundColor.s *= 0.6
	backgroundColor.v *= 0.8
	
	panelStyleBox.bg_color = backgroundColor
	panelStyleBox.border_color = borderColor
	
