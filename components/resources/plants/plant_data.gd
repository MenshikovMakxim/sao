extends Resource
class_name PlantData

@export_category("Основна інформація")
@export var id: String = "unknown"
@export var display_name: String = "Нова Рослина"
@export var cost: int = 50

@export_category("Характеристики")
@export var max_health: float = 100.0

@export_category("Логіка та Атака")
@export var attack_type: Types.AttackType = Types.AttackType.NONE
@export var attack_damage: float = 20.0
@export var attack_rate: float = 1.5
@export var attack_range: int = 5

@export_category("Візуал та Префаби")
@export var visual_model: PackedScene
@export var projectile_scene: PackedScene
