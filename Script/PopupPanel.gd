extends Panel

var last_position

var currently_over

func _process(_delta):
	if last_position != null:
		global_position = last_position
 
func open(object_selected):
	self.visible = true
	last_position = global_position
	if object_selected == 'GolfCart':
		currently_over = object_selected
		$Button.text = 'Travel to town'
		$Button2.text = 'Check storage'

func _on_button_button_up():
	if currently_over:
		pass

func _on_button_2_button_up():
	pass
