class_name EnergyIcon extends TextureRect

signal reparentRequested(energyIcon: EnergyIcon)

const MOVE_TIMER: float = 0.1

@export var creatureStats: CreatureStats

@onready var energyCountLabel: Label = %EnergyCountLabel
@onready var stateMachine: EnergyIconStateMachine = %EnergyIconStateMachine

var originalPosition: Vector2
var dragOffset: Vector2
var stacked: bool = false
var interactable: bool = true

var target: SummonCreature

func _ready() -> void:
	stateMachine.initStateMachine(self)

func _input(event: InputEvent) -> void:
	if interactable:
		stateMachine.onInput(event)

func setEnergyType(_type: CardTypes.EnergyType) -> void:
	pass

func setAmount(amount: int) -> void:
	if amount <= 0:
		energyCountLabel.hide()
	else:
		energyCountLabel.show()
		energyCountLabel.text = str(amount)

func onGuiInput(event: InputEvent) -> void:
	if interactable:
		stateMachine.onGuiInput(event)

func adjustEnergyCount() -> void:
	# TESTING ?
	await get_tree().create_timer(MOVE_TIMER / 2).timeout
	creatureStats.energyCount += 1

func attachEnergy() -> void:
	target.creatureStats.energyCount += 1
	queue_free()

func onEnergyAreaEntered(area: Area2D) -> void:
	if area is SummonCreature:
		target = area

func onEnergyAreaExited(area: Area2D) -> void:
	if area is SummonCreature and area == target:
		target = null
