extends Node

class_name PlanterComponent

@export var raycast: RayCast3D

func get_valid_board() -> GameBoard:
	raycast.force_raycast_update()

	if not raycast.is_colliding():
		return null
		
	var collider = raycast.get_collider()
	if collider is GameBoard:
		return collider as GameBoard 
		
	return null

func try_plant() -> void:
	var board := get_valid_board()

	if board == null:
		return 
		
	var hit_point = raycast.get_collision_point()
	var cell = board.get_cell_from_global(hit_point)

	if cell == Vector2i(-1, -1):
		print("Мимо сітки.") 
		return
		
	if board.request_planting(cell):
		print("Посаджено у клітинку: ", cell)
	else:
		print("Відмова: клітинка ", cell, " зайнята!")
