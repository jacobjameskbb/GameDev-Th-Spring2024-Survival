extends Sprite2D

func _on_area_2d_2_body_entered(body):
	if body.is_in_group('Player'):
		Global.near_golf_cart = true

func _on_area_2d_2_body_exited(body):
	if body.is_in_group('Player'):
		Global.near_golf_cart = false
