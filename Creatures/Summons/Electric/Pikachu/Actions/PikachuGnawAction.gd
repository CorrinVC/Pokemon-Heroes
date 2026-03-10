extends SummonAction

@export var damage: int = 10

func performAction() -> void:
	if not summon or not target:
		super.performAction()
		return
	
	var damageEffect: DamageEffect = DamageEffect.new(damage)
	var targetArray: Array[Creature] = [target]
	
	damageEffect.execute(targetArray)
	super.performAction()
