extends Node3D
class_name VisualSlot

@onready var audio_player: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var launch_marker: Marker3D = $Marker3D

var current_model: Node3D
var anim_player: AnimationPlayer

# 1. Завантаження 3D-моделі
func load_model(model_scene: PackedScene) -> void:
	clear()

	if model_scene == null:
		return
		
	current_model = model_scene.instantiate() as Node3D
	add_child(current_model)

	# Шукаємо AnimationPlayer всередині завантаженої моделі
	anim_player = _find_animation_player(current_model)
	play_animation("idle")

func clear() -> void:
	if current_model:
		current_model.queue_free()
		current_model = null
		anim_player = null

# 2. Анімації
func play_animation(anim_name: String) -> void:
	if anim_player and anim_player.has_animation(anim_name):
		anim_player.play(anim_name)

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

# --- Допоміжний метод пошуку AnimationPlayer ---
func _find_animation_player(node: Node) -> AnimationPlayer:
	if node is AnimationPlayer:
		return node as AnimationPlayer
		
	for child in node.get_children():
		var found = _find_animation_player(child)
		if found:
			return found
			
	return null
