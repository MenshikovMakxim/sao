extends Node3D 

var sensitivity: float = 0.002
var speed: float = 2.0

@onready var camera = $Camera3D
@onready var right_fake_controller = $FakeRightHand
@onready var planter: PlanterComponent = $FakeRightHand/Planter

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * sensitivity)
		camera.rotate_x(-event.relative.y * sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, -1.5, 1.5)
		
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			# Просто смикаємо компонент за ниточку
			planter.try_plant()

func _process(delta):
	var dir = Vector3.ZERO
	if Input.is_key_pressed(KEY_W): dir.z -= 1
	if Input.is_key_pressed(KEY_S): dir.z += 1
	if Input.is_key_pressed(KEY_A): dir.x -= 1
	if Input.is_key_pressed(KEY_D): dir.x += 1
	
	dir = (transform.basis * dir).normalized()
	position += dir * speed * delta

	right_fake_controller.global_position = camera.global_position + camera.global_transform.basis * Vector3(0.2, -0.2, -0.5)
	right_fake_controller.global_rotation = camera.global_rotation
