extends State
class_name PlantAttackState

var _plant: PlantBase
var _attack: RangedAttackComponent
var _visual: VisualSlot

func enter() -> void:
	_plant = actor as PlantBase
	if _plant == null:
		return

	_attack = _plant.ranged_attack
	_visual = _plant.visual_slot

	if _attack:
		_attack.start_attack()
	if _visual:
		_visual.play_animation("Attack")

func exit() -> void:
	if _attack:
		_attack.stop_attack()
	if _visual:
		_visual.play_animation("Idle")

	_plant = null
	_attack = null
	_visual = null

func update(_delta: float) -> void:
	if _plant and not _plant.has_target():
		transition_requested.emit(Types.States.IDLE)
