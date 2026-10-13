extends Node
class_name BoardData

# Наша "база даних"
var cells: Dictionary = {}

# АПІ для перевірки
func can_place(cell: Vector2i) -> bool:
	return not cells.has(cell)

# АПІ для встановлення об'єкта (відразу повертає успіх/фейл)
func place_object(cell: Vector2i, obj: Node3D) -> bool:
	if can_place(cell):
		cells[cell] = obj
		return true
	return false

# АПІ для отримання того, що там стоїть (для зомбі, які будуть це їсти)
func get_object_at(cell: Vector2i) -> Node3D:
	return cells.get(cell, null)

# АПІ для видалення (з'їли/продали)
func clear_cell(cell: Vector2i):
	if cells.has(cell):
		cells.erase(cell)
