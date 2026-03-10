extends CardState

var played: bool

func enter() -> void:
	played = false
	
	if not battleCard.targets.is_empty():
		played = true
		battleCard.play()
	else:
		#battleCard.snapback()
		transitionRequested.emit.call_deferred(self, State.BASE)
