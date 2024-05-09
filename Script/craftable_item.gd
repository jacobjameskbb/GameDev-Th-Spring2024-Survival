extends Control

@export var item: String

var has_enough_resources = false

var resources_passed = 0

var crafting = false

var timer

func _process(_delta):
	if timer != null:
		if Global.dictionary_of_items[item]['Time'] - timer.time_left < Global.dictionary_of_items[item]['Time']:
			Global.Player.get_child(14).value = float(Global.dictionary_of_items[item]['Time'] - timer.time_left)

func _ready():
	$TextureButton.texture_normal = Global.item_sprites[item]

func _on_texture_button_up():
	for resource_needed in Global.dictionary_of_items[item]['Cost'].keys():
			if Global.Player.inventory.has(resource_needed):
				if Global.Player.inventory[resource_needed] >= Global.dictionary_of_items[item]['Cost'][resource_needed]:
					resources_passed += 1
		
	if resources_passed >= Global.dictionary_of_items[item]['Cost'].size():
		has_enough_resources = true
	
	if crafting == false and has_enough_resources == true:
		if (Global.dictionary_of_items[item]['Need_CTable'] == true and Global.Player.in_crafting_area == true) == true or Global.dictionary_of_items[item]['Need_CTable'] == false:
			crafting = true
			Global.Player.crafting = true
			timer = get_tree().create_timer(Global.dictionary_of_items[item]['Time'])
			Global.Player.get_child(14).visible = true
			Global.Player.get_child(14).max_value = Global.dictionary_of_items[item]['Time']
			
			await timer.timeout
			
			if has_enough_resources:
				Global.Player.get_child(14).visible = false
				timer = null
				craft_item()
			
	
	crafting = false
	Global.Player.crafting = false
	resources_passed = 0
	has_enough_resources = false

func craft_item():
	for resource_needed in Global.dictionary_of_items[item]['Cost'].keys():
		if Global.Player.inventory[resource_needed] == Global.dictionary_of_items[item]['Cost'][resource_needed]:
			for child in get_node('/root/BaseGame/Player/MiniMenu/TabContainer/Inventory/ScrollContainer/ItemGridContainer').get_children():
				if child.is_item in Global.dictionary_of_items[item]['Cost'] and child.is_item == resource_needed:
					Global.Player.inventory.erase(resource_needed)
					Global.Player.current_amount_of_items -= Global.dictionary_of_items[item]['Cost'][resource_needed]
					child.item_amount -= Global.dictionary_of_items[item]['Cost'][resource_needed]
					break
		
		elif Global.Player.inventory[resource_needed] > Global.dictionary_of_items[item]['Cost'][resource_needed]:
			for child in get_node('/root/BaseGame/Player/MiniMenu/TabContainer/Inventory/ScrollContainer/ItemGridContainer').get_children():
				if child.is_item in Global.dictionary_of_items[item]['Cost'] and child.is_item == resource_needed:
					Global.Player.inventory[resource_needed] -= Global.dictionary_of_items[item]['Cost'][resource_needed]
					Global.Player.current_amount_of_items -= Global.dictionary_of_items[item]['Cost'][resource_needed]
					child.item_amount -= Global.dictionary_of_items[item]['Cost'][resource_needed]
					break
	
	get_node('/root/BaseGame').add_item_to_inventory(item)
