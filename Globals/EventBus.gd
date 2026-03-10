extends Node

# Playing Card Signals
signal cardPlayed(cardData: CardData)

# Hero Turn Signals
signal heroHandDrawn
signal heroTurnEnded
signal heroHandDiscarded

# Summon Turn Signals
signal summonEnergyGenerated(energyGenerated: int)
signal summonActionsCompleted(summon: SummonCreature)
signal summonTurnEnded

# Enemy Turn Signals
signal enemyActionCompleted(enemy: EnemyCreature)
signal enemyTurnEnded

# Battle Signals
signal fieldPositionChanged
