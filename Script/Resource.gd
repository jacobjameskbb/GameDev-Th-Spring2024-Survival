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
	if Global.Player.inventory.size() < Global.Player.max_inventory_size and Global.Player.current_amount_of_items < Global.Player.max_inventory_size:
		get_node('/root/BaseGame').add_item_to_inventory(is_resource)
		queue_free()
	else:
		pass
