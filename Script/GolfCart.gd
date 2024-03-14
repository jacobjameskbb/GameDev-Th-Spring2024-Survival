extends Sprite2D

var inventory = []




func _on_area_2d_2_body_entered(body):
	if body.is_in_group('Player'):
		Global.in_city = false
