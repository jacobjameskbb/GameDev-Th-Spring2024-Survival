extends Area2D

var over_tile: Vector2

func _process(_delta):
	position = get_global_mouse_position()
	
	if Input.is_action_just_released('RMB'):
		for area in get_overlapping_areas():
			if area.is_in_group('Selectable'):
				var object_selected
				if area.is_in_group('GolfCart'):
					object_selected = 'GolfCart'
				get_node('/root/BaseGame/Panel').open(object_selected)
	
	if get_node('/root/BaseGame/Player').building:
		check_position()
	
	

func check_position():
	over_tile = position.snapped(Vector2(32,32)) - Vector2(16,16)
