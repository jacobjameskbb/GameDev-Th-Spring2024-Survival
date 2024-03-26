extends CharacterBody2D

var attacking = false

var wandering = true

@export var is_enemy = 0

func _ready():
	if is_enemy == 0:
		$CollisionShape2D.shape = CircleShape2D.new()
		$CollisionShape2D.shape.radius = 44

func _process(_delta):
	if is_enemy == 0:
		if wandering == true:
			for possible_position in get_node('/root/BaseGame').island_area:
				pass
