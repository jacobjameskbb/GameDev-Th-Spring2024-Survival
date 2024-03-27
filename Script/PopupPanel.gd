extends Panel

var currently_over
 
func open(object_selected):
	position = get_node('/root/BaseGame/Mouse').global_position
	self.visible = true
	if object_selected == 'GolfCart' and Global.in_city:
		currently_over = object_selected
		$Button.text = 'Travel to base'
		$Button2.text = 'Check storage'
	else:
		currently_over = object_selected
		$Button.text = 'Travel to town'
		$Button2.text = 'Check storage'

func close():
	self.visible = false

func _on_button_button_up():
	if currently_over == 'GolfCart':
		get_node('/root/BaseGame/Player').position = get_node(str('/root/BaseGame/Position',str(int(Global.in_city)))).position

	self.close()

func _on_button_2_button_up():
	if currently_over == 'GolfCart':
		pass

	self.close()
