extends Resource
class_name ProjectileData

@export var id: String = "pea"
@export var speed: float = 4.0
@export var damage: float = 20.0
# На якій відстані (в метрах) візуально фіксувати влучання
@export var hit_distance: float = 0.1 

# Сцена з 3D-мешем горошини (без логіки, тільки графіка та партикли)
@export var visual_scene: PackedScene 
@export var impact_fx_scene: PackedScene # Ефект при влучанні (бризки)
