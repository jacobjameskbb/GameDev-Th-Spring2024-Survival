extends TextureButton

var is_resource

func spawn_in(resource):
	is_resource = resource
	
	self.texture_normal = Global.list_of_resources_sprites[is_resource]

func _on_button_button_up():
	if Global.Player.inventory.size() < Global.Player.max_inventory_size and Global.Player.current_amount_of_items < Global.Player.max_inventory_size and Global.Player.mouse_in_area == true:
		get_node('/root/BaseGame').add_item_to_inventory(is_resource)
		self.queue_free()
	else:
		pass
