class_name DamageEffect extends BattleEffect

var amount: int = 0
var factorProtect: bool = true

func _init(damageAmount: int, factorInProtect: bool = true) -> void:
	amount = damageAmount
	factorProtect = factorInProtect

func execute(targets: Array[Creature]) -> void:
	for target in targets:
		if not target:
			continue
		target.takeDamage(amount, factorProtect)
