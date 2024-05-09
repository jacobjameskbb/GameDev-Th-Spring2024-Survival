extends Sprite2D

const SPEED = 1000

func _process(delta):
	self.position += transform.x * 1000 * delta
