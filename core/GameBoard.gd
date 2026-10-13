extends StaticBody3D
class_name GameBoard

@export var cell_size: float = 0.5  # Клітинка
@export var grid_width: int = 9     # Скільки клітинок в ширину
@export var grid_height: int = 5    # Скільки клітинок в глибину

@onready var data: BoardData = $Data
@onready var spawner: PlantSpawner = $PlantSpawner

func request_planting(cell: Vector2i) -> bool:
	if data.can_place(cell):
		var spawn_pos = get_spawn_position(cell)
		var new_plant = spawner.spawn_plant(spawn_pos, get_parent())
		data.place_object(cell, new_plant)
		return true
	return false

func get_cell_from_global(global_pos: Vector3) -> Vector2i:
	# 1. Переводимо глобальні (світові) координати у локальні (відносно центру столу)
	var local_pos = to_local(global_pos)
	
	# 2. Зсуваємо нуль координат у лівий верхній кут столу
	local_pos.x += (grid_width * cell_size) / 2.0
	local_pos.z += (grid_height * cell_size) / 2.0
	
	# 3. Визначаємо індекси клітинки
	var grid_x = int(floor(local_pos.x / cell_size))
	var grid_z = int(floor(local_pos.z / cell_size))
	
	# 4. Перевірка на вихід за межі
	if grid_x >= 0 and grid_x < grid_width and grid_z >= 0 and grid_z < grid_height:
		return Vector2i(grid_x, grid_z)
	
	return Vector2i(-1, -1)

func get_spawn_position(cell: Vector2i) -> Vector3:
	# Рахуємо локальний центр клітинки (на висоті Y = 0 ВІДНОСНО СТОЛУ)
	var local_center = Vector3(
		(cell.x * cell_size) + (cell_size / 2.0) - ((grid_width * cell_size) / 2.0),
		0.0,
		(cell.y * cell_size) + (cell_size / 2.0) - ((grid_height * cell_size) / 2.0)
	)
	# Повертаємо глобальні координати, щоб контролер знав, куди ставити об'єкт
	return to_global(local_center)
