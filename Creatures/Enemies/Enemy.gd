class_name Enemy extends Node2D

@onready var nameLabel: Label = %EnemyName

func onBoundingBoxMouseEntered() -> void:
	nameLabel.show()

func onBoundingBoxMouseExited() -> void:
	nameLabel.hide()
