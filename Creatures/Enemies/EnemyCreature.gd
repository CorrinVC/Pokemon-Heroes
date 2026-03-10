class_name EnemyCreature extends Creature

const INTENT_UI_SCENE = preload("uid://d34holduyrih0")

@export var actionPickerScene: PackedScene

var enemyActionPicker: EnemyActionPicker
var intentUI: IntentUI
var currentAction: EnemyAction : set = setCurrentAction

func _ready() -> void:
	var newIntentUI: IntentUI = INTENT_UI_SCENE.instantiate() as IntentUI
	add_child(newIntentUI)
	intentUI = newIntentUI

func setCurrentAction(value: EnemyAction) -> void:
	currentAction = value
	
	updateIntent()

func setStats(value: CreatureStats) -> void:
	if not value:
		return
	
	if not is_node_ready():
		await ready
	
	super.setStats(value)
	creatureSprite.flip_h = false
	setupAI()

func onStatsChanged() -> void:
	super.onStatsChanged()
	updateAction()

func setTarget(target: Creature) -> void:
	enemyActionPicker.target = target

func setupAI() -> void:
	if enemyActionPicker:
		enemyActionPicker.queue_free()
	
	var newActionPicker: EnemyActionPicker = \
		actionPickerScene.instantiate() as EnemyActionPicker
	add_child(newActionPicker)
	enemyActionPicker = newActionPicker
	enemyActionPicker.enemy = self

func updateAction() -> void:
	if not enemyActionPicker:
		return
	
	if not currentAction:
		currentAction = enemyActionPicker.getAction()
		return
	
	var newConditionalAction: EnemyAction = enemyActionPicker.checkForConditionalActions()
	if not newConditionalAction and not currentAction.isPerformable():
		currentAction = enemyActionPicker.getAction()
	elif newConditionalAction and currentAction != newConditionalAction:
		currentAction = newConditionalAction

func updateIntent() -> void:
	if currentAction:
		intentUI.updateIntent(currentAction.intent)

func performTurn() -> void:
	if not currentAction:
		print_debug(creatureName + " has no Current Action")
		EventBus.enemyActionCompleted.emit(self)
		return
	
	intentUI.hide()
	currentAction.performAction()
