extends Node
class_name PlantSpawner

# Поки що генеруємо циліндр, потім тут буде інстанс PackedScene (префабів)
func spawn_plant(pos: Vector3, parent_node: Node) -> Node3D:
	var mesh_instance = MeshInstance3D.new()
	var cylinder = CylinderMesh.new()
	cylinder.height = 0.2
	cylinder.top_radius = 0.05
	cylinder.bottom_radius = 0.05
	
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(0, 1, 0)
	cylinder.material = material
	
	mesh_instance.mesh = cylinder
	
	# Додаємо рослину у світ
	parent_node.add_child(mesh_instance)
	mesh_instance.global_position = pos + Vector3(0, cylinder.height / 2.0, 0)
	
	return mesh_instance
