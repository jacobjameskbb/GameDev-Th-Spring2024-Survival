extends Panel

var currently_over
 
func open(object_over):
	position = get_node('/root/BaseGame/Mouse').global_position
	currently_over = object_over
	self.visible = true
	for i in Global.dictionary_of_item_actions[object_over]:
		var new_button = Button.new()
		$ScrollContainer/GridContainer.add_child(new_button)
		

func close():
	self.visible = false
	currently_over = null
