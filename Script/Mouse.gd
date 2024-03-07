extends Area2D

func _process(_delta):
	position = get_global_mouse_position()
	
	if Input.is_action_just_released('RMB'):
		for area in get_overlapping_areas():
			if area.is_in_group('Selectable'):
				var object_selected
				if area.is_in_group('GolfCart'):
					object_selected = 'GolfCart'
				
				
				$Panel.open(object_selected)
