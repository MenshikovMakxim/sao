extends Node
class_name ResourceGeneratorComponent

@onready var parent_plant: PlantBase = get_parent() as PlantBase
var generate_timer: Timer

func setup():
	if parent_plant.plant_data.attack_type != Globals.AttackType.PRODUCTION:
		return
		
	generate_timer = Timer.new()
	generate_timer.wait_time = parent_plant.plant_data.attack_rate
	generate_timer.autostart = true
	generate_timer.timeout.connect(_on_generate)
	add_child(generate_timer)

func _on_generate() -> void:
	print("Згенерував сонечко на клітинці: ", parent_plant.cell)
