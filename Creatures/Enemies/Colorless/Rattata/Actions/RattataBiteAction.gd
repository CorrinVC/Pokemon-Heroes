extends EnemyAction

@export var damage: int = 20

func performAction() -> void:
	if not enemy or not target:
		super.performAction()
		return
	
	var damageEffect: DamageEffect = DamageEffect.new(damage)
	var targetArray: Array[Creature] = [target]
	
	damageEffect.execute(targetArray)
	super.performAction()

func updateIntentText() -> void:
	if intent:
		intent.currentText = intent.baseText % damage
