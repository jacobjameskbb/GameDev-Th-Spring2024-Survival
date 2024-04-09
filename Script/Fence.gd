extends StaticBody2D

func spawn_in(type_of_fence, direction):
	$Sprite2D.texture = type_of_fence

	rotation = direction

	pass
