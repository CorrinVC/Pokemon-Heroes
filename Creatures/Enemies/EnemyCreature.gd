class_name EnemyCreature extends Creature

@export var actionPickerScene: PackedScene

var enemyActionPicker: EnemyActionPicker
var currentAction: EnemyAction : set = setCurrentAction

func setCurrentAction(value: EnemyAction) -> void:
	currentAction = value

func setStats(value: CreatureStats) -> void:
	if not value:
		return
	
	super.setStats(value)
	setupAI()

func onStatsChanged() -> void:
	super.onStatsChanged()
	updateAction()

func setTarget(target: Creature) -> void:
	enemyActionPicker.target = target

func setupAI() -> void:
	if enemyActionPicker:
		enemyActionPicker.queue_free()
	
	if not is_node_ready():
		await ready
	
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

func performTurn() -> void:
	if not currentAction:
		print_debug(creatureName + " has no Current Action")
		EventBus.enemyActionCompleted.emit(self)
		return
	
	currentAction.performAction()
