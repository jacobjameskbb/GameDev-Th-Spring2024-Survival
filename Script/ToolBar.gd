extends Control



func _process(_delta):
	if Input.is_action_just_released('inventory'):
		if $Inventory.visible:
			$Inventory.visible = false
		else:
			$Inventory.visible = true

func _on_axe_sprite_button_button_up():
	Global.Player.item_equipped = 'Axe'

func _on_pickaxe_sprite_button_button_up():
	Global.Player.item_equipped = 'Pickaxe'
