extends State
class_name PlantIdleState

var _plant: PlantBase
var _visual: VisualSlot

func enter() -> void:
	_plant = actor as PlantBase
	if _plant == null:
		return

	_visual = _plant.visual_slot
	if _visual:
		_visual.play_animation("Idle")

func exit() -> void:
	_plant = null
	_visual = null

func update(_delta: float) -> void:
	if _plant and _plant.has_target():
		transition_requested.emit(Types.States.ATTACK)
