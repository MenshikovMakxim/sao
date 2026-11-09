extends Node3D
class_name PlantBase

@onready var health := $HealthComponent
@onready var ranged_attack := $RangedAttackComponent
@onready var visual_slot := $VisualSlot
@onready var state_machine: StateMachine = $StateMashine

signal attack_fired(plant: PlantBase, spawn_pos: Vector3, dir: Vector2i)

var _data: PlantData
var data: PlantData:
	get:
		return _data
var _target_checker:  Callable
var attack_data: Dictionary 

func _ready() -> void:
	state_machine.actor = self

## Setup basic properties 
func setup(data: PlantData, target_checker: Callable):
	self._data = data
	self._target_checker = target_checker
	_setup_data()

## Setup properties from self resource
func _setup_data() -> void:
	if health:
		health.set_max_hp(_data.max_health)
		health.died.connect(_on_death)

	if ranged_attack:
		attack_data["type"] = _data.attack_type
		attack_data["rate"] = _data.attack_rate
		attack_data["range"] = _data.attack_range
		ranged_attack.setup()

	if _data.visual_model != null:
		visual_slot.load_model(_data.visual_model)

func has_target() -> bool:
	if not _target_checker.is_valid():
		return false

	return _target_checker.call()

func _on_death():
	state_machine.change_state(Types.States.DEAD)
