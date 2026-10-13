extends Node
class_name GridCursor

@export var raycast: RayCast3D
@export var valid_color: Color = Color(0.0, 1.0, 0.0, 0.5)
@export var invalid_color: Color = Color(1.0, 0.0, 0.0, 0.5)

var cursor: MeshInstance3D
var cursor_material: StandardMaterial3D

func _ready():
	cursor = MeshInstance3D.new()
	var box = BoxMesh.new()
	box.size = Vector3(0.15, 0.01, 0.15) 
	cursor.mesh = box

	cursor_material = StandardMaterial3D.new()
	cursor_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	cursor.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF 
	cursor.material_override = cursor_material

	get_tree().current_scene.call_deferred("add_child", cursor)
	cursor.hide()

func _process(_delta):

	if not raycast.is_colliding():
		cursor.hide()
		return
		
	var collider = raycast.get_collider()
	if not collider is GameBoard:
		cursor.hide()
		return
		
	var board := collider as GameBoard
	var hit_point = raycast.get_collision_point()
	var cell = board.get_cell_from_global(hit_point)

	# Guard 2: Чи ми в межах сітки?
	if cell == Vector2i(-1, -1):
		cursor.hide()
		return
		
	cursor.show()

	if cursor.mesh is BoxMesh:
		cursor.mesh.size = Vector3(board.cell_size, 0.01, board.cell_size)
		
	cursor.global_position = board.get_spawn_position(cell) + Vector3(0, 0.005, 0)

	if board.data.can_place(cell):
		cursor_material.albedo_color = valid_color
	else:
		cursor_material.albedo_color = invalid_color
