extends Node3D
class_name VisualSlot

@onready var audio_player: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var launch_marker: Marker3D = _get_or_create_launch_marker()

var current_model: Node3D
var anim_player: AnimationPlayer

# 1. Завантаження 3D-моделі
func load_model(model_scene: PackedScene) -> void:
	clear()

	if model_scene == null:
		return
		
	current_model = model_scene.instantiate() as Node3D
	add_child(current_model)

	_center_launch_marker(current_model)

	# Шукаємо AnimationPlayer всередині завантаженої моделі
	anim_player = _find_animation_player(current_model)
	play_animation("Idle")

func clear() -> void:
	if current_model:
		current_model.queue_free()
		current_model = null
		anim_player = null

# 2. Анімації
func play_animation(anim_name: String) -> void:
	if anim_player and anim_player.has_animation(anim_name):
		anim_player.play(anim_name)

# Повертає тривалість анімації в секундах
func get_animation_length(anim_name: String) -> float:
	if anim_player and anim_player.has_animation(anim_name):
		return anim_player.get_animation(anim_name).length
	return 0.0

# 3. Звуки (Грає будь-який AudioStream)
func play_sound(stream: AudioStream) -> void:
	if stream and audio_player:
		audio_player.stream = stream
		audio_player.play()

# 4. Точна точка вильоту снаряда (наприклад, з рота Горохостріла)
func get_launch_position() -> Vector3:
	if launch_marker:
		return launch_marker.global_position
	return global_position # Fallback, якщо маркер не налаштовано

func _get_or_create_launch_marker() -> Marker3D:
	var marker := get_node_or_null("Marker3D") as Marker3D
	if marker == null:
		marker = Marker3D.new()
		marker.name = "Marker3D"
		add_child(marker)

	return marker

func _center_launch_marker(model: Node3D) -> void:
	if launch_marker == null:
		return

	var bounds := _get_model_bounds(model)
	if bounds.size == Vector3.ZERO:
		return

	launch_marker.global_position = bounds.get_center()

func _get_model_bounds(node: Node) -> AABB:
	var result := AABB()
	var has_bounds := false

	if node is MeshInstance3D:
		var mesh_instance := node as MeshInstance3D
		result = mesh_instance.global_transform * mesh_instance.get_aabb()
		has_bounds = true

	for child in node.get_children():
		var child_bounds := _get_model_bounds(child)
		if child_bounds.size == Vector3.ZERO:
			continue

		if has_bounds:
			result = result.merge(child_bounds)
		else:
			result = child_bounds
			has_bounds = true

	return result

# --- Допоміжний метод пошуку AnimationPlayer ---
func _find_animation_player(node: Node) -> AnimationPlayer:
	if node is AnimationPlayer:
		return node as AnimationPlayer
		
	for child in node.get_children():
		var found = _find_animation_player(child)
		if found:
			return found
			
	return null
