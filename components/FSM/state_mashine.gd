extends Node
class_name StateMachine

@export var initial_state: Globals.EnemyState = Globals.EnemyState.MOVING
@export var actor: Node3D

var states: Dictionary = {}
var current_state: State

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.state_id] = child
			child.actor = actor
			child.transition_requested.connect(change_state)
			
	#Запуск початкового стану (через call_deferred, щоб усі інші вузли сцени встигли провантажитись)
	call_deferred("change_state", initial_state)

func change_state(new_state_id: Globals.EnemyState) -> void:
	# Перевірка від дурня, щоб не перемикатись на стан, в якому ми вже є
	if current_state and current_state.state_id == new_state_id:
		return
		
	if current_state:
		current_state.exit()
		
	current_state = states.get(new_state_id)

	if current_state:
		current_state.enter()
	else:
		printerr("Помилка FSM: Стан %s не знайдено!" % new_state_id)

func _physics_process(delta: float) -> void:
	# Машина просто делегує оновлення активному стану
	if current_state:
		current_state.update(delta)
