extends Sprite2D

const SPEED = 1000

func _process(delta):
	self.position += transform.x * 1000 * delta

func _on_area_2d_body_entered(body):
	if body.is_in_group('Enemy'):
		body.health += -10
	
	if body.is_in_group('Turret') == false:
		self.queue_free()
