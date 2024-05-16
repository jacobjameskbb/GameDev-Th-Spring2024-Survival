extends Node

@onready var object = preload("res://object.tscn")

#The area of the island without objects
var island_area: PackedVector2Array = []

#The area of the beach without objects
var beach_area: PackedVector2Array = []

var city_area: PackedVector2Array = []

#The positions of all player buildings
var building_positions: PackedVector2Array = []

var list_of_current_objects: Array = []

const foliage_density = 350

const beach_foliage_density = 15

const house_density = 30

const item_amount = 10

const city_object_density = 10

var current_city_object_density = 0

var current_foliage = 0

var current_beach_foliage = 0

var current_amount_of_items = 0

var current_house_density = 0

var time_step: float = 300.0

var is_crafting = false

var list_of_audiostreamplayers: Array = []

signal LMB

func _ready():
	for tile in $TileMap.get_used_cells_by_id(0,0):
		island_area.append(Vector2(tile * 32 + Vector2i(16,16)))
	
	for tile in $TileMap.get_used_cells_by_id(0,8):
		beach_area.append(Vector2(tile * 32 + Vector2i(16,16)))
	
	for tile in $TileMap.get_used_cells_by_id(0,11):
		city_area.append(Vector2(tile * 32 + Vector2i(16,16)))
	
	for child in get_children():
		if child.is_class('AudioStreamPlayer') == true:
			list_of_audiostreamplayers.append(child)
	
	generate_foliage()
	
	new_count_time()

func generate_foliage():
	
	Global.in_city = false
	
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
	
	Global.Player.position = $Position1.position

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
	
	Global.in_city = true
	
	while current_house_density < house_density:
		
		current_house_density += 1
	
	while current_amount_of_items < item_amount:
		var new_item = Global.item_scene.instantiate()
		new_item.position = pick_random_city_position() - Vector2(16,16)
		self.add_child(new_item)
		new_item.make_new_random_item()
		current_amount_of_items += 1
	
	while current_city_object_density < city_object_density:
		var new_object = object.instantiate()
		new_object.position = pick_random_city_position()
		list_of_current_objects.append(new_object)
		current_foliage += 1
		add_child(new_object)
		current_city_object_density += 1
	
	Global.Player.position = $Position0.position

func pick_random_city_position():
	var new_position
	new_position = city_area[randi_range(0,city_area.size() - 1)]
	city_area.remove_at(city_area.find(new_position))
	return new_position

func new_count_time():
	Global.current_time += 1
	
	Global.current_day = floor(Global.current_time / 300) + 1
	
	if Global.current_time == 600:
		Global.types_of_enemies += 1
	
	if Global.current_time == 900:
		Global.types_of_enemies += 1
	
	if Global.current_time == 1200:
		Global.types_of_enemies += 1
	
	if Global.current_time == 1500:
		Global.types_of_enemies += 1
	
	$Player/Day_label.text = "Day : " + str(Global.current_day)
	
	var day_progress = float(Global.current_time % 300) / 300
	
	$Player/ClockHand.rotation = day_progress * 2 * PI
	
	if day_progress == 0.75:
		$DaySong.stop()
		$BeginNight.play()
		spawn_enemies(Global.current_day)
	
	if day_progress >= 0.75 and $BeginNight.is_playing() == false:
		pass
	
	if day_progress > 0 and day_progress < 0.75 and $DaySong.is_playing() == false:
		$DaySong.play()
		$BeginNight.stop()
	
	if day_progress >= 0 and day_progress < 0.5:
		$CanvasModulate.set_color(Color(day_progress + 0.5, day_progress + 0.5, day_progress + 0.5, 1))
	else:
		$CanvasModulate.set_color(Color(1 - (day_progress - 0.5), 1 - (day_progress - 0.5), 1 - (day_progress - 0.5), 1))

func spawn_enemies(difficulty):
	var amount_of_monsters = difficulty + 1
	
	for i in amount_of_monsters:
		var new_monster = Global.enemy_scene.instantiate()
		
		new_monster.position = beach_area[randi_range(0,beach_area.size() - 1)]
		
		new_monster.is_enemy = randi_range(0,Global.types_of_enemies - 1)
		
		self.add_child(new_monster)

func _process(_delta):
	if Input.is_action_just_pressed("LMB"):
		LMB.emit()
	
	if Input.is_action_just_pressed("RMB") and Global.Player.building:
		Global.Player.building = false
		$PlacingSprite.visible = false
	
	if $PlacingSprite.visible == true:
		$PlacingSprite.position = Global.Mouse.over_tile
		if $PlacingSprite.position not in island_area:
			$PlacingSprite/ColorRect.color.g = 0
			$PlacingSprite/ColorRect.color.r = 1
		else:
			$PlacingSprite/ColorRect.color.g = 1
			$PlacingSprite/ColorRect.color.r = 0

func place_object(object_placed, being_affected):
	
	if object_placed in Global.list_of_buildings and being_affected == 'Placing' and is_crafting == false:
		Global.Player.building = true
		$PlacingSprite.texture = Global.item_sprites[object_placed]
		$PlacingSprite.visible = true
		$PlacingSprite.position = Global.Mouse.over_tile
		
		await LMB
		
		if $PlacingSprite.position in island_area and Global.Player.building:
			var new_building = Global.Building_scene.instantiate()
			new_building.position = Global.Mouse.over_tile
			new_building.texture = Global.item_sprites[object_placed]
			new_building.building_type = object_placed
			self.add_child(new_building)
			for child in get_node('/root/BaseGame/Player/MiniMenu/TabContainer/Inventory/ScrollContainer/ItemGridContainer').get_children():
				if child.is_item == object_placed:
					Global.Player.inventory[object_placed] -= 1
					if Global.Player.inventory[object_placed] == 0:
						Global.Player.inventory.erase(object_placed)
					Global.Player.current_amount_of_items -= 1
					child.item_amount -= 1
					break
	
		Global.Player.building = false
		$PlacingSprite.visible = false
	
	if being_affected == 'Placing' and object_placed == 'Turret' and is_crafting == false:
		Global.Player.building = true
		$PlacingSprite.texture = Global.item_sprites[object_placed]
		$PlacingSprite.visible = true
		$PlacingSprite.position = Global.Mouse.over_tile
		
		await LMB
		
		if $PlacingSprite.position in island_area and Global.Player.building:
			var new_turret = Global.turret_scene.instantiate()
			new_turret.position = Global.Mouse.over_tile
			self.add_child(new_turret)
			for child in get_node('/root/BaseGame/Player/MiniMenu/TabContainer/Inventory/ScrollContainer/ItemGridContainer').get_children():
				if child.is_item == object_placed:
					Global.Player.inventory[object_placed] -= 1
					if Global.Player.inventory[object_placed] == 0:
						Global.Player.inventory.erase(object_placed)
					Global.Player.current_amount_of_items -= 1
					child.item_amount -= 1
					break
		
		Global.Player.building = false
		$PlacingSprite.visible = false
	
	if being_affected == 'Dropping' and is_crafting == false:
		if object_placed in Global.list_of_resources:
			var new_resource = Global.resource_scene.instantiate()
			get_node('/root/BaseGame').add_child(new_resource)
			new_resource.position = Global.Player.position - Vector2(16,16)
			new_resource.spawn_in(object_placed)
		else:
			var new_item = Global.item_scene.instantiate()
			get_node('/root/BaseGame').add_child(new_item)
			new_item.position = Global.Player.position
			new_item.spawn_in(object_placed)
		
		if Global.Player.inventory[object_placed] == 1:
			for child in get_node('/root/BaseGame/Player/MiniMenu/TabContainer/Inventory/ScrollContainer/ItemGridContainer').get_children():
				if child.is_item == object_placed:
					Global.Player.inventory.erase(object_placed)
					Global.Player.current_amount_of_items -= 1
					child.item_amount -= 1
					break
		else:
			for child in get_node('/root/BaseGame/Player/MiniMenu/TabContainer/Inventory/ScrollContainer/ItemGridContainer').get_children():
				if child.is_item == object_placed:
					Global.Player.inventory[object_placed] -= 1
					Global.Player.current_amount_of_items -= 1
					child.item_amount -= 1
					break

func add_item_to_inventory(is_item):
	if (is_item in Global.Player.inventory) == false:
		Global.Player.inventory[is_item] = 1
		var new_item = Global.inventory_item_scene.instantiate()
		new_item.is_item = is_item
		Global.Player.current_amount_of_items += 1
		get_node('/root/BaseGame/Player/MiniMenu/TabContainer/Inventory/ScrollContainer/ItemGridContainer').add_child(new_item)
	else:
		for child in get_node('/root/BaseGame/Player/MiniMenu/TabContainer/Inventory/ScrollContainer/ItemGridContainer').get_children():
			if child.is_item == is_item:
				Global.Player.inventory[is_item] += 1
				Global.Player.current_amount_of_items += 1
				child.item_amount += 1
				break
