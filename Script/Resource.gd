extends Sprite2D

@onready var list_of_resources_sprites: Dictionary = {
	'Plank' : preload("res://Assets/Sprites/plank of wood.png")
	
	
	
	
	
}

var resources: Array = [
	'Plank'
	
	
	
	
]

var is_resource

var mouse_in_area = false

func _ready():
	var is_from = 'tree'
	spawn_in(is_from)

func spawn_in(came_from):
	if came_from == 'tree':
		is_resource = resources[0]
	if came_from == 'rock':
		pass
	if came_from == 'scrap pile':
		pass

	texture = list_of_resources_sprites[is_resource]

func _process(_delta):
	pass

func _on_area_2d_mouse_entered():
	mouse_in_area = true

func _on_area_2d_mouse_exited():
	mouse_in_area = false
