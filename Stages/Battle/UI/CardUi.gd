class_name CardUI extends Control

@onready var stateLabel: Label = %StateLabel
@onready var cardStateMachine: CardStateMachine = %CardStateMachine

var dragOffset: Vector2
var tween: Tween

func _ready() -> void:
	cardStateMachine.initStateMachine(self)

func _input(event: InputEvent) -> void:
	cardStateMachine.onInput(event)

func setScale(newScale: float, speed: float) -> void:
	if scale == Vector2.ONE * newScale:
		return
	
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ONE * newScale, speed)

func onGuiInput(event: InputEvent) -> void:
	cardStateMachine.onGuiInput(event)

func onMouseEntered() -> void:
	cardStateMachine.onMouseEntered()

func onMouseExited() -> void:
	cardStateMachine.onMouseExited()
