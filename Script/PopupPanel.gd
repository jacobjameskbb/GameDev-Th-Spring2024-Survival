extends Panel

var currently_over

var current_position: Vector2

var button_text_list: Array = []

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
	for i in Global.dictionary_of_item_actions[object_over]:
		var new_button = Global.Button_scene.instantiate()
		$ScrollContainer/GridContainer.add_child(new_button)
		new_button.set_name(str(i))
		new_button.text = str(i)
		button_text_list.append(str(i))
		new_button.Cbutton_up.connect(_button_input)
		new_button.set_custom_minimum_size(Vector2(80,16))

func close():
	self.visible = false
	is_open = false
	currently_over = null

func _button_input(button_pressed):
	if button_pressed.text == 'Place':
		get_node('/root/BaseGame').place_object(currently_over,'Placing')

	if button_pressed.text == 'Drop':
		get_node('/root/BaseGame').place_object(currently_over,'Dropping')

	if button_pressed.text == 'Use':
		pass

	close()

func _on_mouse_entered():
	mouse_in_panel = true

func _on_mouse_exited():
	mouse_in_panel = false
