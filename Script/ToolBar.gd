extends Control



func _process(_delta):
	if Input.is_action_just_released('inventory'):
		if $Inventory.visible:
			$Inventory.visible = false
		else:
			$Inventory.visible = true



