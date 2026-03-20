extends Node

# Playing Card Signals
signal cardPlayed(cardData: CardData)
signal summonCardPlayed(creatureStats: CreatureStats, summonStats: SummonStats)

# Hero Signals
signal heroHandDrawn
signal heroTurnEnded
signal heroHandDiscarded
signal heroFainted

# Summon Signals
signal summonEnergyGenerated(energyGenerated: int)
signal summonActionsCompleted(summon: SummonCreature)
signal summonTurnEnded
signal summonFainted(summon: SummonCreature)

# Enemy Signals
signal enemyActionCompleted(enemy: EnemyCreature)
signal enemyTurnEnded
signal enemyFainted(enemy: EnemyCreature)

# Battle Signals
signal fieldPositionChanged
signal battleCompleteRequested(outcome: BattleCompletePanel.Outcome)
