extends Node3D
class_name ProjectileManager

var board: GameBoard

## Цю функцію ми підключимо до сигналу attack_fired кожної посадженої рослини
func _on_plant_attack_fired(plant: PlantBase, spawn_pos: Vector3, dir: Vector2i) -> void:
	var proj_data = plant.data.projectile_data
	if proj_data == null:
		return

	var proj = Globals.get_base_projectile()
	add_child(proj)
	
	# tree_exited - це вбудований сигнал Godot, який викликається перед видаленням об'єкта (queue_free)
	proj.tree_exited.connect(_on_projectile_destroyed.bind(proj.get_instance_id()))

	# 4. Запускаємо логіку польоту
	proj.setup(proj_data, board, spawn_pos, dir)

## Відстеження знищення (для дебагу, статистики або ефектів)
func _on_projectile_destroyed(proj_id: int) -> void:
	pass
