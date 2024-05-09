extends Sprite2D

@onready var bullet_scene = preload("res://bullet.tscn")

func _process(_delta):
	look_at(Global.Mouse.position)
	
	if Input.is_action_just_pressed("LMB") and visible and get_parent().inventory.has('Ammo'):
		if get_parent().inventory['Ammo'] > 0:
			var new_bullet = bullet_scene.instantiate()
			new_bullet.position = Global.Player.position
			new_bullet.rotation = rotation
			get_parent().inventory['Ammo'] += -1
			Global.Player.current_amount_of_items += -1
			for child in get_node('/root/BaseGame/Player/MiniMenu/TabContainer/Inventory/ScrollContainer/ItemGridContainer').get_children():
				if child.is_item == 'Ammo':
					child.item_amount -= 1
			get_node('/root/BaseGame').add_child(new_bullet)
