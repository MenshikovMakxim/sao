extends Node3D
class_name PlantBase

@onready var health := $HealthComponent
@onready var ranged_attack := $RangedAttackComponent
@onready var resource_generator := $ResourceGeneratorComponent
@onready var visual_slot := $VisualSlot

# ТЕПЕР ТУТ ЗБЕРІГАЄТЬСЯ ВСЕ
var plant_data: PlantData 
var board: GameBoard
var cell: Vector2i

func initialize(data: PlantData, my_board: GameBoard, my_cell: Vector2i):
	plant_data = data
	board = my_board
	cell = my_cell
	
	health.set_max_hp(plant_data.max_health)
	health.died.connect(_on_death)
	
	# Виклик setup тепер без аргументів! Діти самі все візьмуть.
	if ranged_attack:
		ranged_attack.setup()
	if resource_generator:
		resource_generator.setup()
	
	if plant_data.visual_model != null:
		var model = plant_data.visual_model.instantiate()
		visual_slot.add_child(model)

func _on_death():
	if board:
		board.data.clear_cell(cell)
	queue_free()
