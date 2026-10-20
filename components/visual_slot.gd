extends Node3D
class_name VisualSlot

var current_model: Node3D
var anim_player: AnimationPlayer

# Завантажує префаб і дістає з нього аніматор
func load_model(model_scene: PackedScene) -> void:
	# 1. Очищаємо слот, якщо там вже стояла якась модель
	clear()
	
	if model_scene == null:
		printerr("VisualSlot: Передано порожню модель!")
		return
		
	# 2. Створюємо модель і додаємо в дерево
	current_model = model_scene.instantiate() as Node3D
	add_child(current_model)
	
	# 3. Шукаємо AnimationPlayer всередині моделі
	_find_animation_player(current_model)
	
	# 4. Якщо є анімація спокою - одразу вмикаємо
	play_animation("idle")

# Видаляє поточну модель
func clear() -> void:
	if current_model:
		current_model.queue_free()
		current_model = null
		anim_player = null

# Пускає анімацію за іменем (безпечно, без крашів)
func play_animation(anim_name: String) -> void:
	if anim_player and anim_player.has_animation(anim_name):
		anim_player.play(anim_name)

# --- Приватні методи ---

# Проста рекурсивна функція: перебирає всі вузли моделі, поки не знайде AnimationPlayer
func _find_animation_player(node: Node) -> void:
	# Спочатку перевіряємо дітей першого рівня
	for child in node.get_children():
		if child is AnimationPlayer:
			anim_player = child
			return
			
	# Якщо не знайшли, шукаємо глибше
	for child in node.get_children():
		_find_animation_player(child)
