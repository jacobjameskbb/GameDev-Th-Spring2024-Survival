extends Sprite2D

var is_resource

func spawn_in(resource):
	if resource == 'Plank':
		position.y += 16

	is_resource = resource
	texture = Global.list_of_resources_sprites[is_resource]

func _on_button_button_up():
	if Global.Player.inventory.size() < Global.Player.max_inventory_size and Global.Player.current_amount_of_items < Global.Player.max_inventory_size:
		get_node('/root/BaseGame').add_item_to_inventory(is_resource)
		self.queue_free()
	else:
		pass
