extends Sprite2D

var resources: Array = [
	'Plank',
	'Rock',
	'Scrap',
	'Coconut',
]

var is_resource

func spawn_in(came_from):
	if came_from == 'tree':
		is_resource = resources[0]
		position.y += 16
	if came_from == 'rock':
		is_resource = resources[1]
	if came_from == 'scrap pile':
		is_resource = resources[2]
	if came_from == 'palm tree':
		if 1 == randi_range(0,3):
			is_resource = resources[3]
		else:
			is_resource = resources[0]

	texture = Global.list_of_resources_sprites[is_resource]

func _on_button_button_up():
	if Global.Player.inventory.size() < (Global.Player.max_inventory_size + Global.Player.current_amount_of_items):
		if is_resource not in Global.Player.inventory:
			Global.Player.inventory.append(is_resource)
			var new_item = Global.inventory_item_scene.instantiate()
			new_item.is_item = is_resource
			Global.Player.current_amount_of_items += 1
			get_node('/root/BaseGame/Player/MiniMenu/TabContainer/Inventory/ScrollContainer/ItemGridContainer').add_child(new_item)
		else:
			for child in get_node('/root/BaseGame/Player/MiniMenu/TabContainer/Inventory/ScrollContainer/ItemGridContainer').get_children():
				if child.is_item == is_resource:
					Global.Player.inventory.append(is_resource)
					Global.Player.current_amount_of_items += 1
					child.item_amount += 1
					break
		queue_free()

	else:
		pass
