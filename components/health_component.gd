extends Node
class_name HealthComponent

signal health_changed(current: float, maximum: float)
signal died()

var max_hp: float = 100.0
var current_hp: float = 100.0

var is_dead: bool = false 

func set_max_hp(value: float) -> void:
	max_hp = value
	current_hp = max_hp
	is_dead = false
	health_changed.emit(current_hp, max_hp)

func take_damage(amount: float) -> void:
	if is_dead:
		return
		
	current_hp -= amount
	current_hp = clamp(current_hp, 0.0, max_hp)
	
	health_changed.emit(current_hp, max_hp)
	
	if current_hp <= 0.0:
		is_dead = true
		died.emit()

func heal(amount: float) -> void:
	if is_dead:
		return
		
	current_hp += amount
	current_hp = clamp(current_hp, 0.0, max_hp)
	
	health_changed.emit(current_hp, max_hp)
