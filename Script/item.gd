extends Sprite2D

var items: Array = [
	'Ammo'
	
	
	
]

var is_item

func _ready():
	var random_items: Array
	for i in items:
		random_items.append(i)
	is_item = items[randi_range(0,random_items.size() - 1)]
	texture = Global.items_sprites[is_item]

func _on_button_button_up():
	if Global.Player.inventory.size() < Global.Player.max_inventory_size and Global.Player.current_amount_of_items < Global.Player.max_inventory_size:
		get_node('/root/BaseGame').add_item_to_inventory(is_item)
		queue_free()
	else:
		pass
