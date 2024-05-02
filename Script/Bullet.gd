extends Sprite2D

const SPEED = 1000

func _ready():
	pass

func _process(delta):
	self.transform.origin.x +=  SPEED * delta
