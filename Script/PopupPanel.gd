extends Panel

var currently_over

var current_position: Vector2

var is_open = false

var mouse_in_panel = false

func _process(_delta):
	position = Global.Player.position + current_position
	
	if mouse_in_panel == false and self.visible:
		if Input.is_action_just_pressed("LMB") or Input.is_action_just_pressed('RMB'):
			
			self.close()

func open(object_over):
	is_open = true
	current_position = -(Global.Player.position - Global.Mouse.position)
	for child in $ScrollContainer/GridContainer.get_children():
		child.queue_free()
	position = get_node('/root/BaseGame/Mouse').global_position
	currently_over = object_over
	self.visible = true
	var count = 0
	for i in Global.dictionary_of_item_actions[object_over]:
		var new_button = Global.Button_scene.instantiate()
		$ScrollContainer/GridContainer.add_child(new_button)
		new_button.button_id = count
		new_button.set_name(str(i))
		new_button.text = str(i)
		new_button.Cbutton_up.connect(_button_input)
		new_button.set_custom_minimum_size(Vector2(80,16))
		count += 1

func close():
	self.visible = false
	is_open = false
	currently_over = null

func _button_input(button_pressed):
	print('AAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHH')
	if button_pressed.button_id == 0:
		get_node('/root/BaseGame').place_object(currently_over)

	if button_pressed.button_id == 1:
		pass

	if button_pressed.button_id == 2:
		pass

	close()

func _on_mouse_entered():
	mouse_in_panel = true
	print(mouse_in_panel)

func _on_mouse_exited():
	mouse_in_panel = false
	print(mouse_in_panel)
