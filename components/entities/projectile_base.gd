extends Node3D
class_name ProjectileBase

var data: ProjectileData
var board: GameBoard
var direction: Vector3 = Vector3.FORWARD

func setup(proj_data: ProjectileData, my_board: GameBoard, start_pos: Vector3, face_dir: Vector2i):
	data = proj_data
	board = my_board
	global_position = start_pos
	
	# Перетворюємо напрямок на сітці (Vector2i) у 3D вектор (Vector3)
	direction = Vector3(face_dir.x, 0, face_dir.y).normalized()
	
	# Завантажуємо візуал
	if data.visual_scene:
		add_child(data.visual_scene.instantiate())

func _process(delta: float):
	if data == null or board == null:
		return
		
	# 1. Фізично летимо вперед
	global_position += direction * data.speed * delta
	
	# 2. Питаємо дошку: в якій клітинці ми зараз?
	var current_cell = board.get_cell_from_global(global_position)
	
	# Якщо вилетіли за межі столу - видаляємося (щоб не засмічувати пам'ять)
	if current_cell == Vector2i(-1, -1):
		queue_free()
		return
		
	# 3. Перевіряємо, чи є в цій клітинці зомбі
	var target = board.data.get_first_enemy_at(current_cell)
	
	if target != null and target.is_in_group("enemies"):
		var dist = global_position.distance_to(target.global_position)
		if dist <= data.hit_distance:
			impact(target)

func impact(target: Node3D):
	# Завдаємо шкоди через наш HealthComponent
	if target.has_node("HealthComponent"):
		target.get_node("HealthComponent").take_damage(data.damage)
		
	# Спавнимо ефект вибуху горошини (якщо він є)
	if data.impact_fx_scene:
		var fx = data.impact_fx_scene.instantiate()
		board.get_parent().add_child(fx)
		fx.global_position = global_position
		
	queue_free() # Знищуємо снаряд
