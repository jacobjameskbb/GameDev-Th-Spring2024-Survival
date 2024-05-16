extends Control

var currently_over

var current_position: Vector2

var button_text_list: Array = []

var is_open = false

var closing = false

var mouse_in_panel = false

var in_pstorage = false

func _process(_delta):
	position = Global.Player.position + current_position
	
	if mouse_in_panel == false and self.visible:
		if Input.is_action_just_pressed("LMB") or Input.is_action_just_pressed('RMB'):
			self.close()

func open(object_over, in_storage = false):
	if closing == false:
		is_open = true
		in_pstorage = in_storage
		current_position = -(Global.Player.position - Global.Mouse.position)
		for child in $ScrollContainer/GridContainer.get_children():
			child.queue_free()
		position = Global.Mouse.global_position
		currently_over = object_over
		self.visible = true
		for i in Global.dictionary_of_item_actions[object_over]:
			var new_button = Global.Button_scene.instantiate()
			$ScrollContainer/GridContainer.add_child(new_button)
			new_button.set_name(str(i))
			new_button.text = str(i)
			button_text_list.append(str(i))
			new_button.Cbutton_up.connect(_button_input)
			new_button.set_custom_minimum_size(Vector2(80,16))
		if Global.Player.moving_items:
			var new_button = Global.Button_scene.instantiate()
			$ScrollContainer/GridContainer.add_child(new_button)
			new_button.set_name(str('Move'))
			new_button.text = str('Move')
			button_text_list.append(str('Move'))
			new_button.Cbutton_up.connect(_button_input)
			new_button.set_custom_minimum_size(Vector2(80,16))

func close():
	closing = true
	self.visible = false
	is_open = false
	currently_over = null
	
	var timer = get_tree().create_timer(0.00001)
	await timer.timeout
	
	closing = false

func _button_input(button_pressed):
	if button_pressed.text == 'Place':
		get_parent().place_object(currently_over,'Placing')
	
	if button_pressed.text == 'Drop':
		get_parent().place_object(currently_over,'Dropping')
	
	if button_pressed.text == 'Move':
		Global.Player.move_item(currently_over, in_pstorage)
	
	if button_pressed.text == 'Travel to city':
		get_parent().generate_city()
	
	if button_pressed.text == 'Check storage' and Global.near_golf_cart:
		Global.Player.get_node('GolfCartInventory').open()
		if Global.Player.get_node('MiniMenu').visible == false:
			Global.Player.get_node('MiniMenu').visible = true
	
	if button_pressed.text == 'Travel to base':
		get_parent().generate_foliage()
	
	self.close()

func _on_mouse_entered():
	mouse_in_panel = true

func _on_mouse_exited():
	mouse_in_panel = false
