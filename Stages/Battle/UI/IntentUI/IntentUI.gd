class_name IntentUI extends VBoxContainer

@onready var intentIcon: TextureRect = %IntentIcon
@onready var valueTextLabel: Label = %ValueTextLabel

func updateIntent(intent: EnemyIntent) -> void:
	if not intent:
		hide()
		return
	
	intentIcon.texture = intent.icon
	intentIcon.visible = intentIcon.texture != null
	
	valueTextLabel.text = str(intent.currentText)
	valueTextLabel.visible = intent.currentText.length() > 0
