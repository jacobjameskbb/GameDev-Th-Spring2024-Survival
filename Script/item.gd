extends Sprite2D

var items: Array = [
	
	
	
	
]

var is_item

func _ready():
	var random_items: Array
	for i in items:
		random_items.append(i)
	is_item = items[randi_range(0,random_items.size() - 1)]
	texture = Global.items_sprites[is_item]

func _on_button_button_up():
	if is_item not in Global.Player.inventory:
		Global.Player.inventory.append(is_item)
		var new_item = Global.inventory_item_scene.instantiate()
		new_item.is_item = is_item
		get_node('/root/BaseGame/Camera/Inventory/ItemGridContainer').add_child(new_item)
	else:
		for child in get_node('/root/BaseGame/Camera/Inventory/ItemGridContainer').get_children():
			if child.is_item == is_item:
				child.item_amount += 1
