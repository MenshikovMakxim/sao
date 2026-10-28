extends Node3D
class_name PlantBase

@onready var health := $HealthComponent
@onready var ranged_attack := $RangedAttackComponent
@onready var resource_generator := $ResourceGeneratorComponent
@onready var visual_slot := $VisualSlot

signal attack_fired(plant: PlantBase, spawn_pos: Vector3, dir: Vector2i)

var _data: PlantData
var _target_checker:  Callable
var attack_data: Dictionary 

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
		
	if resource_generator:
		resource_generator.setup()
	
	if _data.visual_model != null:
		visual_slot.load_model(_data.visual_model)

func _on_death():
	queue_free()
