extends Control



func _process(_delta):
	if Input.is_action_just_released('inventory'):
		if $ScrollContainer.visible:
			$ScrollContainer.visible = false
		else:
			$ScrollContainer.visible = true



