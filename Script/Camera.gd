extends Camera2D

var player

var target_position: Vector2

var stopped_moving = true

func _ready():
	for object in get_parent().get_children():
		if object.is_in_group('Player'):
			player = object

func _physics_process(_delta):
	if target_position != player.position:
		target_position = player.position
		if stopped_moving == true:
			stopped_moving = false
	else:
		stopped_moving = true
	move_towards_player()

func move_towards_player():
	if Vector2(Vector2i(position)) in near() and stopped_moving:
		position = target_position
	elif position != target_position:
		position += Vector2(Vector2i(position.direction_to(target_position) * (player.speed / 5000 + 1.5)))

func near():
	var array_of_near_positions: PackedVector2Array = []
	array_of_near_positions.append(target_position)
	for x in range(-8,9):
		for y in range(-8,9):
			array_of_near_positions.append(Vector2(Vector2i(target_position + Vector2(x,y))))
	return array_of_near_positions
