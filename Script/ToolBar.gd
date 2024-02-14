extends Control

func _process(_delta):
	if Input.is_action_just_released('inventory'):
		if $Inventory.visible:
			$Inventory.visible = false
		else:
			$Inventory.visible = true

	if Input.is_action_just_released('axe'):
		_on_axe_sprite_button_button_up()

	if Input.is_action_just_released('pickaxe'):
		_on_pickaxe_sprite_button_button_up()

func _on_axe_sprite_button_button_up():
	Global.Player.item_equipped = 'Axe'

func _on_pickaxe_sprite_button_button_up():
	Global.Player.item_equipped = 'Pickaxe'
