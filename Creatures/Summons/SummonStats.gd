class_name SummonStats extends Resource

@export var actions: Array[SummonAction] = []

func createInstance() -> SummonStats:
	var instance: SummonStats = self.duplicate()
	
	return instance
