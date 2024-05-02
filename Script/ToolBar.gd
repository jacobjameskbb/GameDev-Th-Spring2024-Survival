extends Control

func _process(_delta):
	if Input.is_action_just_released('axe'):
		_on_axe_sprite_button_button_up()
	
	if Input.is_action_just_released('pickaxe'):
		_on_pickaxe_sprite_button_button_up()
	
	if Input.is_action_just_released("gun"):
		_on_texture_button_button_up()

	if Global.Player.item_equipped != 'Gun':
		get_node('/root/BaseGame/Player/Gun').visible = false

func _on_axe_sprite_button_button_up():
	if Global.Player.item_equipped != 'Axe':
		Global.Player.item_equipped = 'Axe'
		get_node('/root/BaseGame/Player').get_child(3).animation = 'chopping_default'
	else:
		get_node('/root/BaseGame/Player').get_child(3).animation = 'no_tool'
		Global.Player.item_equipped = null

func _on_pickaxe_sprite_button_button_up():
	if Global.Player.item_equipped != 'Pickaxe':
		Global.Player.item_equipped = 'Pickaxe'
		get_node('/root/BaseGame/Player').get_child(3).animation = 'mining_default'
	else:
		get_node('/root/BaseGame/Player').get_child(3).animation = 'no_tool'
		Global.Player.item_equipped = null

func _on_texture_button_button_up():
	if Global.Player.item_equipped != 'Gun':
		get_node('/root/BaseGame/Player/Gun').visible = true
		Global.Player.item_equipped = 'Gun'
		get_node('/root/BaseGame/Player').get_child(3).animation = 'no_tool'
	else:
		get_node('/root/BaseGame/Player').get_child(3).animation = 'no_tool'
		Global.Player.item_equipped = null
