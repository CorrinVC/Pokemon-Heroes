extends CardData

@export var damage: int = 5

func playCard(targets: Array[Area2D]) -> void:
	var cardTargets: Array[Creature] = getCardTargets(targets)
	
	var damageEffect: DamageEffect = DamageEffect.new(damage)
	damageEffect.execute(cardTargets)
	
	super.playCard(targets)
