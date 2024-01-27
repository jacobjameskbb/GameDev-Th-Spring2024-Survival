extends Sprite2D

@onready var items: Dictionary = {
	'plank of wood': preload("res://Assets/Sprites/plank of wood.png")
	
	
	
	
	
	}

var is_item

func _ready():
	var random_items = []
	for i in items.keys():
		random_items.append(i)
	is_item = items[random_items[randi_range(0,random_items.size() - 1)]]
	print(is_item)
	texture = is_item

func _process(_delta):
	pass
