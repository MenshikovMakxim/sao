extends Node3D
class_name EnemyBase

@onready var health := $HealthComponent

var board: GameBoard
var cell: Vector2i = Vector2i(-1, -1)

func setup(my_board: GameBoard, start_cell: Vector2i, max_hp: float = 100.0) -> void:
	board = my_board
	cell = start_cell

	add_to_group("enemies")
	health.set_max_hp(max_hp)
	health.died.connect(_on_death)

	board.data.add_enemy(cell, self)

func _on_death() -> void:
	if board:
		board.data.remove_enemy(cell, self)

	queue_free()
