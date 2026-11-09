extends Node
class_name RangedAttackComponent

const DEFAULT_ATTACK_RATE: float = 1.5
const ATTACK_TYPE: Types.AttackType = Types.AttackType.RANGED

var parent: PlantBase
var facing_direction: Vector2i = Vector2i(1, 0)
var _cooldown: Timer
var _is_attacking: bool = false

func _ready() -> void:
	parent = get_parent() as PlantBase

func setup() -> void:
	parent = get_parent() as PlantBase
	if parent == null:
		return
	if parent.attack_data.get("type") != ATTACK_TYPE:
		return
	if _cooldown != null:
		return

	_cooldown = Timer.new()
	_cooldown.wait_time = maxf(float(parent.attack_data.get("rate", DEFAULT_ATTACK_RATE)), 0.01)
	_cooldown.timeout.connect(_on_attack_tick)
	add_child(_cooldown)

func start_attack() -> void:
	if _cooldown == null or _is_attacking:
		return

	_is_attacking = true
	_on_attack_tick()
	_cooldown.start()

func stop_attack() -> void:
	_is_attacking = false
	if _cooldown:
		_cooldown.stop()

func _on_attack_tick() -> void:
	if not _is_attacking or parent == null:
		return
	if not parent.has_target():
		return

	var spawn_position := parent.global_position
	if parent.visual_slot:
		spawn_position = parent.visual_slot.get_launch_position()

	parent.attack_fired.emit(parent, spawn_position, facing_direction)
