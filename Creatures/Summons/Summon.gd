class_name Summon extends Node2D

@onready var nameLabel: Label = %SummonName

func onBoundingBoxMouseEntered() -> void:
	nameLabel.show()

func onBoundingBoxMouseExited() -> void:
	nameLabel.hide()
