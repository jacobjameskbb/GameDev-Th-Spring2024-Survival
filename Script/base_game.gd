extends Node

@onready var object = preload("res://object.tscn")

var island_area: PackedVector2Array = []

var beach_area: PackedVector2Array = []

var city_area: PackedVector2Array = []

var building_position: PackedVector2Array = []

var list_of_current_objects: Array = []

const foliage_density = 600

const beach_foliage_density = 15

var current_foliage = 0

var current_beach_foliage = 0

var time_step: float = 300.0

func _ready():
	for tile in $TileMap.get_used_cells_by_id(0,0):
		if tile not in [Vector2i(0,0),Vector2i(-1,0),Vector2i(0,-1),Vector2i(-1,-1)]:
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
	$Player/MTime.text = str(int($Player/MTime.text) + 1)

	if int($Player/MTime.text) < 10:
		$Player/MTime.text = str('0',$Player/MTime.text)

	if int($Player/MTime.text) == 60:
		$Player/MTime.text = str('00')
		if int($Player/HTime.text) < 19:
			$Player/HTime.text = str(int($Player/HTime.text) + 1)
		else:
			$Player/HTime.text = str(0)

	if Global.after_noon == false:
		time_step += 1.0
		$CanvasModulate.set_color(Color((0.392 + time_step/1200.0),(0.392 + time_step/1200.0),(0.392 + time_step/1200.0),1))

	if Global.after_noon == true:
		time_step += -1.0
		$CanvasModulate.set_color(Color((0.392 + time_step/1200.0),(0.392 + time_step/1200.0),(0.392 + time_step/1200.0),1))

	if time_step == 600 or (time_step < 0):
		if Global.after_noon == false:
			Global.after_noon = true
		else:
			Global.after_noon = false
		if Global.after_noon == false:
			Global.day += 1
			$Player/Day_value_label.text = str(Global.day)

	if time_step == 180 and Global.after_noon == true:
		$DaySong.stop()
		$BeginNight.play()

	count_time()
