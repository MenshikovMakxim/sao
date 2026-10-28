extends Node

#Constants
const PLANT_BASE_SCENE = preload("res://components/entities/plant_base.tscn")
const PROJECTILE_BASE_SCENE = preload("res://components/entities/ProjectileBase.tscn")

func get_base_plant() -> PlantBase:
	return PLANT_BASE_SCENE.instantiate() as PlantBase

func get_base_projectile() -> ProjectileBase:
	return PROJECTILE_BASE_SCENE.instantiate() as ProjectileBase

# ==========================================
# РЕЄСТР РОСЛИН
# ==========================================
var plants_db: Dictionary = {
	# Ключ - це ID, значення - файл налаштувань (Resource)
	"test_plant": null,
}

func get_plant(id: String) -> PlantData:
	if plants_db.has(id):
		return plants_db[id]
	printerr("Помилка: Рослину '", id, "' не знайдено в базі!")
	return null
	
#var plants_db: Dictionary = {
	#"peashooter": preload("res://resources/plants/peashooter.tres"),
	#"sunflower": preload("res://resources/plants/sunflower.tres"),
	## ... інші
#}
#
#func get_plant(id: String) -> PlantData:
	#if plants_db.has(id):
		#return plants_db[id]
	#printerr("Помилка: Рослину '", id, "' не знайдено!")
	#return null
