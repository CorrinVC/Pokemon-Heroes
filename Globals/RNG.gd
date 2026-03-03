extends Node

var instance: RandomNumberGenerator

func _ready() -> void:
	initialize()

func initialize() -> void:
	instance = RandomNumberGenerator.new()
	instance.randomize()

# TODO
func setFromSaveData(_saveSeed: int, _saveState: int) -> void:
	pass

func arrayPickRandom(array: Array) -> Variant:
	if array.is_empty():
		return null
	
	return array[instance.randi() % array.size()]

func arrayShuffle(array: Array) -> void:
	if array.size() < 2:
		return
	
	for i in range(array.size() - 1, 0, -1):
		var j: int = instance.randi() % (i + 1)
		var temp: Variant = array[j]
		array[j] = array[i]
		array[i] = temp
