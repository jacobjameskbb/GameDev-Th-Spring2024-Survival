extends Sprite2D

@onready var items_sprites: Dictionary = {
	
	
	
	
	
}

var items: Array = [
	
	
	
	
]

var is_item

var mouse_in_area = false

func _ready():
	var random_items: Array
	for i in items:
		random_items.append(i)
	is_item = items[randi_range(0,random_items.size() - 1)]
	texture = items_sprites[is_item]

func _process(_delta):
	pass

func _on_area_2d_mouse_entered():
	mouse_in_area = true

func _on_area_2d_mouse_exited():
	mouse_in_area = false
