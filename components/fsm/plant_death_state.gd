extends State
class_name PlantDeathState

const DEATH_ANIMATION: String = "death"

var _plant: PlantBase
var _visual: VisualSlot

func enter() -> void:
	_plant = actor as PlantBase
	if _plant == null:
		return

	if _plant.ranged_attack:
		_plant.ranged_attack.stop_attack()

	_visual = _plant.visual_slot
	if _visual:
		_visual.play_animation(DEATH_ANIMATION)

	_free_after_animation()

func exit() -> void:
	_plant = null
	_visual = null

func _free_after_animation() -> void:
	var duration := 0.0
	if _visual and _visual.anim_player and _visual.anim_player.has_animation(DEATH_ANIMATION):
		duration = _visual.anim_player.get_animation(DEATH_ANIMATION).length

	if duration > 0.0:
		await get_tree().create_timer(duration).timeout

	if is_instance_valid(_plant):
		_plant.queue_free()
