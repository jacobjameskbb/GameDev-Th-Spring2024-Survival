extends Panel

var last_position

func _process(_delta):
	if last_position != null:
		global_position = last_position
 
func open(object_selected):
	self.visible = true
	last_position = global_position
	if object_selected == 'GolfCart':
		$Button.text = 'Travel to town'
		$Button2.text = 'Check storage'
	
