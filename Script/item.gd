extends Sprite2D

var random_items: Array = [
	'Ammo',
	
]

var is_item

func make_new_random_item():
	is_item = random_items[randi_range(0,random_items.size() - 1)]
	texture = Global.items_sprites[is_item]

func spawn_in(item):
	is_item = item
	texture = Global.item_sprites[is_item]

func _on_button_button_up():
	if Global.Player.inventory.size() < Global.Player.max_inventory_size and Global.Player.current_amount_of_items < Global.Player.max_inventory_size:
		get_node('/root/BaseGame').add_item_to_inventory(is_item)
		queue_free()
	else:
		pass
