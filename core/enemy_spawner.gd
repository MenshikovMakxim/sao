extends Node
class_name EnemySpawner

const ENEMY_BASE_SCENE = preload("res://components/entities/enemy_base.tscn")

func spawn(board: GameBoard, cell: Vector2i, max_hp: float = 100.0) -> EnemyBase:
	var enemy := ENEMY_BASE_SCENE.instantiate() as EnemyBase
	if enemy == null:
		return null

	add_child(enemy)
	enemy.global_position = board.get_spawn_position(cell)
	enemy.setup(board, cell, max_hp)

	print("Спавнер створив ворога в клітинці: ", cell)
	return enemy
