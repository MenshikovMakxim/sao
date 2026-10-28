extends StaticBody3D
class_name GameBoard

@export var cell_size: float = 0.5  # Клітинка
@export var grid_width: int = 9     # Скільки клітинок в ширину
@export var grid_height: int = 5    # Скільки клітинок в глибину

@onready var data: BoardData = $Data
@onready var spawner: PlantSpawner = $PlantSpawner
@onready var enemies_place: Node = $Enemies
@onready var proj_manager: ProjectileBase = $ProjectileManager

func _ready() -> void:
	proj_manager.board = self

## Try to spawn plant by seed
func try_planting(cell: Vector2i, seed_id: String) -> bool:
	if not data.can_place(cell):
		return false
		
	# Дістаємо дані заздалегідь, щоб знати радіус атаки для лямбди
	var plant_data = Globals.get_plant(seed_id)
	if plant_data == null:
		return false
		
	var spawn_pos = get_spawn_position(cell)

	var target_checker = func() -> bool:
		return _has_enemy_in_line(cell, Vector2i(1, 0), plant_data.attack_range)
		
	var new_plant = spawner.spawn(plant_data, spawn_pos, target_checker)

	new_plant.attack_fired.connect(proj_manager._on_plant_attack_fired)
	data.place_plant(cell, new_plant)

	return true
#func try_planting(cell: Vector2i, seed_id: String) -> bool:
	#if data.can_place(cell):
		#var spawn_pos = get_spawn_position(cell)
		#var new_plant = spawner.spawn(seed_id)
		#data.place_plant(cell, new_plant)
		#return true
	#return false
	#var target_checker = func() -> bool:
		#return _has_enemy_in_line(cell, Vector2i(1, 0), new_plant.data.attack_range)

func _has_enemy_in_line(from_cell: Vector2i, dir: Vector2i, max_range: int) -> bool:
	for i in range(1, max_range + 1):
		var check_cell = from_cell + (dir * i)
		if data.get_first_enemy_at(check_cell) != null:
			return true
	return false

## Translate from global coordinates into local coordinates of the center board
func get_cell_from_global(global_pos: Vector3) -> Vector2i:

	var local_pos = to_local(global_pos)
	
	local_pos.x += (grid_width * cell_size) / 2.0
	local_pos.z += (grid_height * cell_size) / 2.0
	
	var grid_x = int(floor(local_pos.x / cell_size))
	var grid_z = int(floor(local_pos.z / cell_size))
	
	if grid_x >= 0 and grid_x < grid_width and grid_z >= 0 and grid_z < grid_height:
		return Vector2i(grid_x, grid_z)
	
	return Vector2i(-1, -1)

## Calculate local center of the cell (on Y = 0)
func get_spawn_position(cell: Vector2i) -> Vector3:
	var local_center = Vector3(
		(cell.x * cell_size) + (cell_size / 2.0) - ((grid_width * cell_size) / 2.0),
		0.0,
		(cell.y * cell_size) + (cell_size / 2.0) - ((grid_height * cell_size) / 2.0)
	)
	return to_global(local_center)
