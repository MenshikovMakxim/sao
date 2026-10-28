extends Node
class_name RangedAttackComponent

# Отримуємо батька і кажемо рушію, що це точно PlantBase
@onready var parent: PlantBase
@onready var attack_data: Dictionary = parent.attack_data

func _ready() -> void:
	parent = get_parent() as PlantBase

var facing_direction: Vector2i = Vector2i(1, 0) 
var _cooldown: Timer
var type = Types.AttackType.RANGED

func setup():
	if attack_data["type"] != type:
		return

func _cooldown_timer():
	_cooldown = Timer.new()
	_cooldown.wait_time = attack_data["rate"]
	_cooldown.autostart = true
	add_child(_cooldown)
