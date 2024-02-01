extends Node

@onready var object = preload("res://object.tscn")

var island_area: PackedVector2Array = []

var city_area: PackedVector2Array = []

var list_of_current_objects: Array = []

const foliage_density = 600

var current_foliage = 0

func _ready():
	for tile in $TileMap.get_used_cells_by_id(0,0):
		island_area.append(Vector2(tile * 32 + Vector2i(16,16)))

	generate_foliage()

func generate_foliage():
	while current_foliage < foliage_density:
		var new_object = object.instantiate()
		new_object.position = pick_random_foliage_position()
		list_of_current_objects.append(new_object)
		current_foliage += 1
		add_child(new_object)

func pick_random_foliage_position():
	var position_picked
	position_picked = island_area[randi_range(0,island_area.size() - 1)]
	island_area.remove_at(island_area.find(position_picked))
	return position_picked

func generate_city():
	pass

func _on_quit_button_up():
	get_tree().quit()
