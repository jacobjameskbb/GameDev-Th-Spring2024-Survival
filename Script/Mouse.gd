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
				$Panel.open(object_selected)

	check_position()

func check_position():
	if Vector2(Vector2i(position)) in get_parent().list_of_tile_positions:
		over_tile = Vector2i(get_parent().dictionary_of_tile_sprites.find_key(Vector2i(position)))
