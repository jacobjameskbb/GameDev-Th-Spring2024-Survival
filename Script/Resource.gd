extends Sprite2D

@onready var resources: Dictionary = {
	'plank of wood' : preload("res://Assets/Sprites/plank of wood.png")
	
	
	
	
	
}

var is_resource

func _ready():
	var is_from = 'tree'
	spawn_in(is_from)


func spawn_in(came_from):
	if came_from == 'tree':
		is_resource = resources['plank of wood']
	if came_from == 'rock':
		pass
	if came_from == 'scrap pile':
		pass

	texture = is_resource

func _process(_delta):
	pass
