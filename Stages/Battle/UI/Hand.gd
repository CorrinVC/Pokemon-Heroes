extends Control

const BATTLE_CARD_SCENE: PackedScene = preload("uid://b08l1filbqkwg")

@export var heroCreature: HeroCreature

@export var handPositionCurve: Curve
@export var handRotationCurve: Curve

func _ready() -> void:
	for node in get_children():
		node.queue_free()
	
	for i in range(heroCreature.heroStats.cardsPerTurn):
		addCard(heroCreature.heroStats.deck.drawCard())
	
	child_order_changed.connect(onHandChanged)

func addCard(cardData: CardData) -> void:
	var newBattleCard: BattleCard = \
		BATTLE_CARD_SCENE.instantiate() as BattleCard
	
	add_child(newBattleCard)
	newBattleCard.cardData = cardData
	newBattleCard.reparentRequested.connect(onCardReparentRequested)

func onCardReparentRequested(battleCard: BattleCard) -> void:
	if battleCard in get_children():
		return
	
	battleCard.reparent(self)
	var handIndex: int = clampi(battleCard.originalHandIndex, 0, get_child_count())
	move_child.call_deferred(battleCard, handIndex)

func onHandChanged() -> void:
	for i in range(get_child_count()):
		var card: BattleCard = get_children()[i]
		
		assert(handPositionCurve and handRotationCurve, "No Hand Curve Set")
		
		var index: float = i / float(get_child_count() - 1)
		if get_child_count() == 1:
			index = 0.5
		
		var cardXPosition: float = 75 * (i - get_child_count() / 2.0)
		var cardYPosition: float = -110 - handPositionCurve.sample(index)
		var newPosition: Vector2 = Vector2(cardXPosition, cardYPosition)
		
		var newRotation: float = handRotationCurve.sample(index)
		
		var tween: Tween = create_tween().set_parallel()
		tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		tween.tween_property(card, "position", newPosition, 0.2)
		tween.tween_property(card, "rotation_degrees", newRotation, 0.4)
