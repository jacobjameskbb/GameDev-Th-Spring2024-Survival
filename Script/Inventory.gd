extends Control

func _process(_delta):
	if Input.is_action_just_released('inventory'):
		if self.visible:
			self.visible = false
		else:
			self.visible = true
