extends Sprite2D

@onready var bullet_scene = preload("res://bullet.tscn")

func _process(_delta):
	look_at(Global.Mouse.position)
	
	if Input.is_action_just_pressed("LMB") and visible:
		var new_bullet = bullet_scene.instantiate()
		new_bullet.position = Global.Player.position
		new_bullet.rotation = rotation
		get_node('/root/BaseGame').add_child(new_bullet)
