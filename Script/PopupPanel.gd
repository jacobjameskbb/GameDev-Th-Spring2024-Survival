extends Panel

var currently_over
 
func open(object_over):
	position = get_node('/root/BaseGame/Mouse').global_position
	currently_over = object_over
	self.visible = true
	var count = 0
	for i in Global.dictionary_of_item_actions[object_over]:
		var new_button = Button.new()
		$ScrollContainer/GridContainer.add_child(new_button)
		new_button.set_name(str(count))
		new_button.text = str(i)
		new_button.button_up.connect(_button_input,new_button.get_name())
		new_button.set_custom_minimum_size(Vector2(80,16))
		count += 1

func close():
	for child in $ScrollContainer/GridContainer.get_children():
		child.queue_free()
	self.visible = false
	currently_over = null

func _button_input(button_pressed):
	print(button_pressed)

	if button_pressed == '0':
		pass

	if button_pressed == '1':
		pass

	if button_pressed == '2':
		pass
