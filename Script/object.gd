extends Sprite2D

@onready var objects: Dictionary = {
	'Tree' : preload("res://Assets/Sprites/Tree.png"),
	'Rock' : preload("res://Assets/Sprites/Rock.png"),
	'Scrap pile' : preload("res://Assets/Sprites/Scrap pile.png"),
}

var only_city: Array = [
	'Scrap pile',
	
]

@onready var resource_scene = preload("res://resource.tscn")

var is_object

var hit_points = 200

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
		$StaticBody2D.global_position += Vector2(0,16)
	if objects['Rock'] == is_object:
		hit_points *= 2

func _process(_delta):
	if hit_points <= 0:
		var new_resource = resource_scene.instantiate()
		get_node('/root/BaseGame').add_child(new_resource)
		new_resource.position = position
		if objects['Tree'] == is_object:
			new_resource.spawn_in('tree')
		if objects['Rock'] == is_object:
			new_resource.spawn_in('rock')
		if objects['Scrap pile'] == is_object:
			new_resource.spawn_in('scrap pile')
		queue_free()

func _on_button_button_up():
	if objects['Tree'] == is_object:
		if Global.Player.item_equipped == 'Axe':
			hit_points += -10 * Global.Player.axe_level
