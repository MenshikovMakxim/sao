extends Node
class_name BoardData

# Головний словник. 
# Ключ: Vector2i (координати клітинки)
# Значення: Словник з двома полями {"plant": Node3D, "enemies": Array}
var grid: Dictionary = {}

# Приватна функція: якщо клітинки ще немає в словнику, вона її створює
func _get_or_create_cell(cell: Vector2i) -> Dictionary:
	if not grid.has(cell):
		grid[cell] = {
			"plant": null,
			"enemies": [] # Зомбі може бути багато, тому це масив
		}
	return grid[cell]

# ==========================================
# 1. ЛОГІКА РОСЛИН
# ==========================================

func can_place(cell: Vector2i) -> bool:
	var cell_data = _get_or_create_cell(cell)
	# Садити можна тільки якщо там немає іншої рослини
	return cell_data["plant"] == null

func place_plant(cell: Vector2i, plant: Node3D) -> void:
	var cell_data = _get_or_create_cell(cell)
	cell_data["plant"] = plant

func remove_plant(cell: Vector2i) -> void:
	if grid.has(cell):
		grid[cell]["plant"] = null

func get_plant_at(cell: Vector2i) -> Node3D:
	if grid.has(cell):
		return grid[cell]["plant"]
	return null

# ==========================================
# 2. ЛОГІКА ЗОМБІ (ВОРОГІВ)
# ==========================================

func add_enemy(cell: Vector2i, enemy: Node3D) -> void:
	var cell_data = _get_or_create_cell(cell)
	if not enemy in cell_data["enemies"]:
		cell_data["enemies"].append(enemy)

func remove_enemy(cell: Vector2i, enemy: Node3D) -> void:
	if grid.has(cell):
		grid[cell]["enemies"].erase(enemy)

# Отримати всіх зомбі в клітинці (наприклад, для Вишневої Бомби)
func get_enemies_at(cell: Vector2i) -> Array:
	if grid.has(cell):
		return grid[cell]["enemies"]
	return []

# Зручна функція для Горошини (беремо першого ліпшого зомбі, щоб завдати шкоди)
func get_first_enemy_at(cell: Vector2i) -> Node3D:
	var enemies = get_enemies_at(cell)
	if enemies.size() > 0:
		return enemies[0]
	return null
