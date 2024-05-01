extends Node2D

var mouse_on_door = false

func _ready():
	var rn = randi_range(0,10)
	if (rn in [8,9]) == false:
		$Sprite2D.texture = Global.house_sprites[randi_range(0,Global.house_sprites.size() - 1)]
	else:
		pass

func _process(_delta):
	pass

func _on_area_2d_mouse_entered():
	mouse_on_door = true

func _on_area_2d_mouse_exited():
	mouse_on_door = false
