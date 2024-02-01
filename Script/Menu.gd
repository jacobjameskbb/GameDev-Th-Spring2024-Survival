extends Control

func _process(_delta):
	if Input.is_action_just_released("menu"):
		if $PopUpMenu.visible:
			$PopUpMenu.visible = false
		else:
			$PopUpMenu.visible = true
