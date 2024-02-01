extends Sprite2D

@onready var objects: Dictionary = {
	'Tree' : preload("res://Assets/Sprites/Tree.png"),
	'Rock' : preload("res://Assets/Sprites/Rock.png"),
	'Scrap pile' : preload("res://Assets/Sprites/Scrap pile.png"),
}

var only_city: Array = [
	'Scrap pile',
	
]

var is_object

var hit_points = 100

func _ready():
	var random_objects = []
	if Global.in_city == false:
		for i in objects.keys():
			if i not in only_city:
				random_objects.append(i)
	else:
		for i in objects.keys():
			if i in only_city:
				random_objects.append(i)
	is_object = objects[random_objects[randi_range(0,random_objects.size() - 1)]]
	texture = is_object

	if objects['Tree'] == is_object:
		position += Vector2(0,-16)
		$Area2D.global_position += Vector2(0,16)
		z_index += 1

func _process(_delta):
	pass
