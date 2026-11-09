extends State
class_name PlantIdleState

var _visual: VisualSlot

func enter() -> void:
	var plant := actor as PlantBase
	if plant == null:
		return

	_visual = plant.visual_slot
	if _visual:
		_visual.play_animation("Idle")

func exit() -> void:
	_visual = null
