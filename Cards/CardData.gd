class_name CardData extends Resource

#const TARGET_ALL: String = "targetAll"
const TARGET_FRIENDLY: String = "targetFriendly"
const TARGET_HOSTILE: String = "targetHostile"

enum Target {
	SINGLE,
	SINGLE_FRIENDLY,
	SINGLE_HOSTILE,
	ALL_FRIENDLY,
	ALL_HOSTILE
}

@export var cardName: String
@export var cardArt: Texture
@export var cardType: CardTypes.CardType
@export var energyType: CardTypes.EnergyType
@export var rarity: CardTypes.Rarity
@export var energyCost: int
@export var target: Target
@export_multiline var cardText: String

func playCard(targets: Array[Area2D]) -> void:
	EventBus.cardPlayed.emit(self)
	
	var cardTargets: Array[Creature] = getCardTargets(targets)
	for creature in cardTargets:
		creature.creatureStats.takeDamage(2)

func getCardTargets(targets: Array[Area2D]) -> Array[Creature]:
	if not targets:
		return []
		
	if isSingleTargeted() and targets[0] is Creature:
		return [targets[0] as Creature]
	
	var cardTargets: Array[Creature] = []
	var sceneTree: SceneTree = targets[0].get_tree()
	
	match target:
		Target.ALL_FRIENDLY:
			cardTargets = getTargetsInGroup(sceneTree, TARGET_FRIENDLY)
		Target.ALL_HOSTILE:
			cardTargets = getTargetsInGroup(sceneTree, TARGET_HOSTILE)
	
	return cardTargets

func getTargetsInGroup(tree: SceneTree, groupName: String) -> Array[Creature]:
	var targetsInGroup :=  tree.get_nodes_in_group(groupName)
	var targetCreatures: Array[Creature] = []
	
	for creature in targetsInGroup:
		if creature is Creature:
			targetCreatures.append(creature)
	
	return targetCreatures

func isSingleTargeted() -> bool:
	return target == Target.SINGLE or target == Target.SINGLE_FRIENDLY \
		or target == Target.SINGLE_HOSTILE
