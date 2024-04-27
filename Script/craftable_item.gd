extends Control

@export var item: String

var has_enough_resources = false

var resources_passed = 0

func _ready():
	$TextureButton.texture_normal = Global.item_sprites[item]

func _on_texture_button_up():
	craft_item()

func craft_item():
	for resource_needed in Global.dictionary_of_items[item]['Cost'].keys():
		if Global.Player.inventory.has(resource_needed):
			if Global.Player.inventory[resource_needed] >= Global.dictionary_of_items[item]['Cost'][resource_needed]:
				resources_passed += 1
				if Global.Player.inventory[resource_needed] == Global.dictionary_of_items[item]['Cost'][resource_needed]:
					for child in get_node('/root/BaseGame/Player/MiniMenu/TabContainer/Inventory/ScrollContainer/ItemGridContainer').get_children():
						if child.is_item in Global.dictionary_of_items[item]['Cost']:
							Global.Player.inventory[resource_needed] -= Global.dictionary_of_items[item]['Cost'][resource_needed]
							Global.Player.current_amount_of_items -= Global.dictionary_of_items[item]['Cost'][resource_needed]
							child.queue_free()
							print(resource_needed)
							break
					
					Global.Player.inventory.erase(resource_needed)
				
				elif Global.Player.inventory[resource_needed] > Global.dictionary_of_items[item]['Cost'][resource_needed]:
					for child in get_node('/root/BaseGame/Player/MiniMenu/TabContainer/Inventory/ScrollContainer/ItemGridContainer').get_children():
						if child.is_item in Global.dictionary_of_items[item]['Cost']:
							Global.Player.inventory[resource_needed] -= Global.dictionary_of_items[item]['Cost'][resource_needed]
							Global.Player.current_amount_of_items -= Global.dictionary_of_items[item]['Cost'][resource_needed]
							child.item_amount -= Global.dictionary_of_items[item]['Cost'][resource_needed]
							break
					
					Global.Player.inventory[resource_needed] -= Global.dictionary_of_items[item]['Cost'][resource_needed]
			else:
				break
		else:
			break
	
	if resources_passed == Global.dictionary_of_items[item]['Cost'].size():
		has_enough_resources = true
	
	if has_enough_resources == true:
		get_node('/root/BaseGame').add_item_to_inventory(item)
	
	resources_passed = 0
	has_enough_resources = false
