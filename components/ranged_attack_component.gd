extends Node
class_name RangedAttackComponent

# Отримуємо батька і кажемо рушію, що це точно PlantBase
@onready var parent_plant: PlantBase = get_parent() as PlantBase

var facing_direction: Vector2i = Vector2i(1, 0) 
var attack_timer: Timer

func setup():
	if parent_plant.plant_data.attack_type != Globals.AttackType.RANGED:
		return
		
	attack_timer = Timer.new()
	attack_timer.wait_time = parent_plant.plant_data.attack_rate
	attack_timer.autostart = true
	attack_timer.timeout.connect(_on_attack_tick)
	add_child(attack_timer)

func _on_attack_tick() -> void:
	if check_for_enemies():
		shoot()

func check_for_enemies() -> bool:
	for i in range(1, parent_plant.plant_data.attack_range + 1):
		# Читаємо cell та board з батька
		var check_cell = parent_plant.cell + (facing_direction * i)
		var target = parent_plant.board.data.get_object_at(check_cell)

		if target != null and target.is_in_group("enemies"):
			return true
		
	return false

func shoot() -> void:
	print("Постріл з клітинки: ", parent_plant.cell)
	# Логіка створення снаряда...
