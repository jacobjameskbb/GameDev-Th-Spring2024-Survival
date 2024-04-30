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

var current_foliage = 0

var current_beach_foliage = 0

var time_step: float = 300.0

signal LMB

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

func _process(_delta):
	if Input.is_action_just_pressed("LMB"):
		LMB.emit()
	if $PlacingSprite.visible == true:
		$PlacingSprite.position = Global.Mouse.over_tile
		if $PlacingSprite.position not in island_area:
			$PlacingSprite/ColorRect.color.g = 0
			$PlacingSprite/ColorRect.color.r = 1
		else:
			$PlacingSprite/ColorRect.color.g = 1
			$PlacingSprite/ColorRect.color.r = 0

func place_object(object_placed, being_affected):
	
	if object_placed in Global.list_of_buildings and being_affected == 'Placing':
		Global.Player.building = true
		$PlacingSprite.texture = Global.item_sprites[object_placed]
		$PlacingSprite.visible = true
		$PlacingSprite.position = Global.Mouse.over_tile
		
		await LMB
		
		Global.Player.building = false
		$PlacingSprite.visible = false
		
		if $PlacingSprite.position in island_area:
			var new_building = Global.Building_scene.instantiate()
			new_building.position = Global.Mouse.over_tile
			new_building.texture = Global.item_sprites[object_placed]
			new_building.building_type = object_placed
			self.add_child(new_building)
			if Global.Player.inventory[object_placed] == 0:
				for child in get_node('/root/BaseGame/Player/MiniMenu/TabContainer/Inventory/ScrollContainer/ItemGridContainer').get_children():
					if child.is_item == object_placed:
						Global.Player.inventory[object_placed] -= 1
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
	
	if being_affected == 'Dropping':
		if object_placed in Global.list_of_resources:
			var new_resource = Global.resource_scene.instantiate()
			get_node('/root/BaseGame').add_child(new_resource)
			new_resource.position = Global.Player.position
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
	
	if object_placed in Global.list_of_items:
		
		
		
		
		
		pass

func add_item_to_inventory(is_item):
	if is_item not in Global.Player.inventory:
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


