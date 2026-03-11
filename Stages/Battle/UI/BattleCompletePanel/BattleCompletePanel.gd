class_name BattleCompletePanel extends Control

const FADE_DURATION: float = 0.2

enum Outcome { WIN, LOSS }

@onready var splashLabel: Label = %SplashLabel
@onready var continueButton: Button = %ContinueButton

func _ready() -> void:
	continueButton.pressed.connect(get_tree().quit)
	EventBus.battleCompleteRequested.connect(showScreen)
	modulate = Color.TRANSPARENT

func showScreen(outcome: Outcome) -> void:
	if outcome == Outcome.WIN:
		splashLabel.text = "Hero Victorious!"
	else:
		splashLabel.text = "Hero Defeated."
	
	show()
	get_tree().paused = true
	
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, FADE_DURATION)
