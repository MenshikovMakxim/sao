extends XROrigin3D

var xr_interface: XRInterface

func _ready():
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR ініціалізовано успішно!")
		
		# Вимикаємо V-Sync для VR (вимога продуктивності)
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

		# Направляємо рендер у шолом
		get_viewport().use_xr = true
	else:
		print("Помилка OpenXR! Шолом не знайдено.")
