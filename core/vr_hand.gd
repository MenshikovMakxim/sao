extends XRController3D

@onready var planter: PlanterComponent = $Planter

func _ready():
	# Підключаємося до нативного сигналу натискання кнопок VR-контролера
	button_pressed.connect(_on_button_pressed)

func _on_button_pressed(action_name: String):
	# В OpenXR тригер зазвичай називається "trigger_click" або як ти налаштував у Action Map
	if action_name == "trigger_click":
		planter.try_plant()
