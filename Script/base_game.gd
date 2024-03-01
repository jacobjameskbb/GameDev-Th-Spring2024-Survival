extends Node

@onready var object = preload("res://object.tscn")

var island_area: PackedVector2Array = []

var beach_area: PackedVector2Array = []

var city_area: PackedVector2Array = []

var list_of_current_objects: Array = []

const foliage_density = 600

const beach_foliage_density = 15

var current_foliage = 0

var current_beach_foliage = 0

var time_step: float = 0.0

func _ready():
	for tile in $TileMap.get_used_cells_by_id(0,0):
		island_area.append(Vector2(tile * 32 + Vector2i(16,16)))

	for tile in $TileMap.get_used_cells_by_id(0,8):
		beach_area.append(Vector2(tile * 32 + Vector2i(16,16)))

	generate_foliage()

	count_time()

func generate_foliage():
	while current_foliage < foliage_density:
		var new_object = object.instantiate()
		new_object.position = pick_random_foliage_position()
		list_of_current_objects.append(new_object)
		current_foliage += 1
		add_child(new_object)

	while current_beach_foliage < beach_foliage_density:
		var new_object = object.instantiate()
		new_object.position = pick_random_beach_foliage_position()
		new_object.is_on_beach = true
		list_of_current_objects.append(new_object)
		current_beach_foliage += 1
		add_child(new_object)

func pick_random_foliage_position():
	var position_picked
	position_picked = island_area[randi_range(0,island_area.size() - 1)]
	island_area.remove_at(island_area.find(position_picked))
	return position_picked

func pick_random_beach_foliage_position():
	var position_picked
	position_picked = beach_area[randi_range(0,beach_area.size() - 1)]
	beach_area.remove_at(beach_area.find(position_picked))
	return position_picked

func generate_city():
	pass

func _on_quit_button_up():
	get_tree().quit()

func count_time():
	await $Timer.timeout
	Global.current_time += 1
	$Player/Time.text = str(time_step)
	if Global.after_noon == false:
		time_step += 1.0
		$CanvasModulate.set_color(Color((0.392 + time_step/1200.0),(0.392 + time_step/1200.0),(0.392 + time_step/1200.0),1))
	if time_step == 600 or (time_step == 0 and Global.day != 0):
		if Global.after_noon == false:
			Global.after_noon = true
		else:
			Global.after_noon = false
		Global.day += 1
		$Player/Day_value_label.text = str(Global.day)
	if Global.after_noon == true:
		time_step += -1.0
		$CanvasModulate.set_color(Color((0.392 + time_step/1200.0),(0.392 + time_step/1200.0),(0.392 + time_step/1200.0),1))
	count_time()





