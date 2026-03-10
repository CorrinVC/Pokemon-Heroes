class_name BattleCard extends Control

signal reparentRequested(battleCard: BattleCard)

const BASE_SPEED: float = 0.1

@export var cardData: CardData : set = setCardData
@export var creatureStats: CreatureStats : set = setCreatureStats

@onready var cardVisuals: CardVisuals = %CardVisuals
@onready var boundingBox: Area2D = %BoundingBox
@onready var stateLabel: Label = %StateLabel
@onready var cardStateMachine: BattleCardStateMachine = %CardStateMachine
@onready var targets: Array[Area2D] = []

var originalHandIndex: int
var dragOffset: Vector2
var tween: Tween

var playable: bool = true : set = setPlayable

func _ready() -> void:
	cardStateMachine.initStateMachine(self)

func _input(event: InputEvent) -> void:
	cardStateMachine.onInput(event)

func setCardData(value: CardData) -> void:
	if not is_node_ready():
		await ready
	
	cardData = value
	cardVisuals.cardData = cardData
	updateBoundingBoxCollisionMask()

func setCreatureStats(value: CreatureStats) -> void:
	creatureStats = value
	creatureStats.statsChanged.connect(onCreatureStatsChanged)
	onCreatureStatsChanged()

func setPlayable(value: bool) -> void:
	playable = value
	cardVisuals.setPlayable(playable)

func setScale(newScale: float, speed: float) -> void:
	if scale == Vector2.ONE * newScale:
		return
	
	if tween:
		tween.kill()
	
	tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2.ONE * newScale, speed)

func play() -> void:
	if tween:
		tween.kill()
	
	tween = create_tween()
	var cardTargets: Array[Area2D] = targets.duplicate()
	
	# Snap to Target
	if cardData.isSingleTargeted():
		var shortOffset: Vector2 = Vector2(0, 28)
		var newPosition: Vector2 = targets[0].global_position - (size / 2) + shortOffset
		tween.tween_property(self, "global_position", newPosition, BASE_SPEED / 2)
	tween.tween_interval(BASE_SPEED)
	
	# Shrink and Fade
	tween.set_parallel()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, BASE_SPEED)
	tween.tween_property(self, "scale", Vector2.ONE * 0.75, BASE_SPEED).set_ease(Tween.EASE_OUT)
	tween.finished.connect(func() -> void:
		cardData.playCard(cardTargets)
		queue_free()
	)

func onCreatureStatsChanged() -> void:
	playable = creatureStats.energyCount >= cardData.energyCost

func onGuiInput(event: InputEvent) -> void:
	cardStateMachine.onGuiInput(event)

func onMouseEntered() -> void:
	cardStateMachine.onMouseEntered()

func onMouseExited() -> void:
	cardStateMachine.onMouseExited()

func onBoundingBoxEntered(area: Area2D) -> void:
	if not targets.has(area):
		targets.append(area)

func onBoundingBoxExited(area: Area2D) -> void:
	targets.erase(area)

func updateBoundingBoxCollisionMask() -> void:
	var maskLayer: int = 1	
	
	match cardData.target:
		CardData.Target.SINGLE:
			maskLayer = 0xe
		CardData.Target.SINGLE_FRIENDLY:
			maskLayer = 0x6
		CardData.Target.SINGLE_HOSTILE:
			maskLayer = 0x8
		_:
			maskLayer = 0x1
	
	boundingBox.collision_mask = maskLayer

#func checkForValidTarget(target: Area2D) -> bool:
	#var valid: bool = false
	#
	#if not cardData:
		#return false
	#
	#match cardData.target:
		#CardData.Target.SINGLE:
			#valid = target.is_in_group(TARGET_FRIENDLY) or target.is_in_group(TARGET_HOSTILE)
		#CardData.Target.SINGLE_FRIENDLY:
			#valid = target.is_in_group(TARGET_FRIENDLY)
		#CardData.Target.SINGLE_HOSTILE:
			#valid = target.is_in_group(TARGET_HOSTILE)
		#CardData.Target.ALL_FRIENDLY:
			#valid = target.is_in_group(TARGET_ALL) or target.is_in_group(TARGET_FRIENDLY)
		#CardData.Target.ALL_HOSTILE:
			#valid = target.is_in_group(TARGET_ALL) or target.is_in_group(TARGET_HOSTILE)
	#
	#return valid
