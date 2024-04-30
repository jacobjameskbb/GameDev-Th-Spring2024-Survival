extends Control

@export var item: String

var has_enough_resources = false

var resources_passed = []

var crafting = false

var timer

func _process(_delta):
	if timer != null:
		if timer.time_left < 100:
			Global.Player.get_child(14).value = Global.dictionary_of_items[item]['Time'] - timer.time_left

func _ready():
	$TextureButton.texture_normal = Global.item_sprites[item]

func _on_texture_button_up():
	if not crafting:
		for resource_needed in Global.dictionary_of_items[item]['Cost'].keys():
			if Global.Player.inventory.has(resource_needed):
				if Global.Player.inventory[resource_needed] >= Global.dictionary_of_items[item]['Cost'][resource_needed]:
					resources_passed.append(resource_needed)
		
		if resources_passed in Global.dictionary_of_items[item]['Cost']:
			has_enough_resources = true
		
		if has_enough_resources:
			timer = get_tree().create_timer(Global.dictionary_of_items[item]['Time'])
			Global.Player.get_child(14).visible = true
			Global.Player.get_child(14).max_value = Global.dictionary_of_items[item]['Time']
			await timer.timeout
			Global.Player.get_child(14).visible = false
			timer = null
			craft_item()

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
	resources_passed = 0
	has_enough_resources = false
