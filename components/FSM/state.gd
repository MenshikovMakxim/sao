extends Node
class_name State

# Сигнал для команди Машині: "Перемикай мене на ось це"
signal transition_requested(new_state: Globals.EnemyState)

# В інспекторі ти будеш вибирати, який саме це стан (з нашого Globals)
@export var state_id: Globals.EnemyState

# Посилання на головний вузол (зомбі), щоб рухати його і брати його змінні
var actor: Node3D 

# Викликається один раз при вході в стан (наприклад, увімкнути анімацію)
func enter() -> void:
	pass

# Викликається перед виходом (наприклад, зупинити таймер)
func exit() -> void:
	pass

# Заміна стандартного _process, керується Машиною
func update(delta: float) -> void:
	pass
