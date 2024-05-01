extends Area2D

var over_tile: Vector2

func _process(_delta):
	position = get_global_mouse_position()
	
	if Input.is_action_just_released('LMB'):
		for area in get_overlapping_areas():
			if area.is_in_group('Selectable'):
				var object_selected
				
				for group in area.get_groups():
					if group in Global.dictionary_of_item_actions.keys():
						object_selected = group
				
				get_node('/root/BaseGame/Panel').open(object_selected)
	
	if Global.Player.building:
		check_position()

func check_position():
	over_tile = position.snapped(Vector2(32,32)) - Vector2(16,16)
