extends Node
class_name PlantSpawner


func spawn(plant_data: PlantData, spawn_pos: Vector3, target_checker: Callable) -> PlantBase:
	var plant = Globals.get_base_plant() as PlantBase
	plant.setup(plant_data, target_checker)
	plant.global_position = spawn_pos
	add_child(plant)


	print("Спавнер виростив: ", plant_data.display_name)
	return plant

#func spawn(seed_id: String) -> PlantBase:
	#
	#var plant_data = Globals.get_plant(seed_id)
	#if plant_data == null:
		#return
		#
	#var ready_plant = Globals.get_base_plant()
	#add_child(ready_plant)
	#ready_plant.setup(plant_data)
	#
	#print("Успішно створено: ", plant_data.display_name)
	#return ready_plant

## Поки що генеруємо циліндр, потім тут буде інстанс PackedScene (префабів)
#func spawn_plant(board: GameBoard, pos: Vector3, parent_node: Node) -> Node3D:
#
	##var mesh_instance = MeshInstance3D.new()
	##var cylinder = CylinderMesh.new()
	##cylinder.height = 0.2
	##cylinder.top_radius = 0.05
	##cylinder.bottom_radius = 0.05
	##
	##var material = StandardMaterial3D.new()
	##material.albedo_color = Color(0, 1, 0)
	##cylinder.material = material
	##
	##mesh_instance.mesh = cylinder
	##
	### Додаємо рослину у світ
	##parent_node.add_child(mesh_instance)
	##mesh_instance.global_position = pos + Vector3(0, cylinder.height / 2.0, 0)
	#
	#return mesh_instance
