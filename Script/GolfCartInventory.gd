extends Control

func open():
	self.visible = true
	get_parent().moving_items = true

func _on_button_button_up():
	self.visible = false
	get_parent().moving_items = false
