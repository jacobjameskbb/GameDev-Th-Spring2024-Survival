extends CharacterBody2D

var speed = 400

var inventory: Dictionary = {}

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(_delta):
	get_input()
	move_and_slide()

	for area in $ReachArea.get_overlapping_areas():
		if area.is_in_group('Item') and area.mouse_in_area == true:
			if Input.is_action_pressed("Pickup"):
				inventory[str(area)] = area
				area.visible = false






