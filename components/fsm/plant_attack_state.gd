extends State
class_name PlantAttackState

var _attack: RangedAttackComponent
var _visual: VisualSlot

func enter() -> void:
	var plant := actor as PlantBase
	if plant == null:
		return

	_attack = plant.ranged_attack
	_visual = plant.visual_slot

	if _attack:
		_attack.start_attack()
	if _visual:
		_visual.play_animation("attack")

func exit() -> void:
	if _attack:
		_attack.stop_attack()
	if _visual:
		_visual.play_animation("idle")

	_attack = null
	_visual = null
