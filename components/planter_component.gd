extends Node
class_name PlanterComponent

@export var raycast: RayCast3D

func _get_valid_board() -> GameBoard:
	raycast.force_raycast_update()

	if not raycast.is_colliding():
		return null
		
	var collider = raycast.get_collider()
	if collider is GameBoard:
		return collider as GameBoard 
		
	return null
	
## Try to plant seed, send cell coordinates to GameBoard
func try_plant(seed_id: String) -> void:
	var board := _get_valid_board()

	if board == null:
		return 
		
	var hit_point = raycast.get_collision_point()
	var cell = board.get_cell_from_global(hit_point)
	
	board.try_planting(cell, seed_id)
