extends Camera2D

var player

func _ready():
	for object in get_parent().get_children():
		if object.is_in_group('Player'):
			player = object

func _process(_delta):
	position = player.position
