class_name Hero extends Node2D

@onready var nameLabel: Label = %HeroName

func onBoundingBoxMouseEntered() -> void:
	nameLabel.show()

func onBoundingBoxMouseExited() -> void:
	nameLabel.hide()
