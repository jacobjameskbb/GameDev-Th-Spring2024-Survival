extends TextureButton

var random_items: Array = [
	'Ammo',
	
]

var is_item

func make_new_random_item():
	is_item = random_items[randi_range(0,random_items.size() - 1)]
	texture_normal = Global.item_sprites[is_item]

func spawn_in(item):
	is_item = item
	texture_normal = Global.item_sprites[is_item]

func _on_button_button_up():
	if Global.Player.inventory.size() < Global.Player.max_inventory_size and Global.Player.current_amount_of_items < Global.Player.max_inventory_size and Global.Player.mouse_in_area == true:
		get_node('/root/BaseGame').add_item_to_inventory(is_item)
		get_node('/root/BaseGame').city_area.append(self.position + Vector2(16,16))
		get_node('/root/BaseGame').current_amount_of_items += -1
		queue_free()
