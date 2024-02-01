extends CharacterBody2D

var speed = 20000

var inventory: Array = []

var max_inventory_size = 10

func get_input(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed * delta

func _physics_process(delta):
	get_input(delta)
	move_and_slide()

	for area in $ReachArea.get_overlapping_areas():
		if area.get_parent().is_in_group('Item') and area.mouse_in_area == true and Input.is_action_pressed('pickup'):
			if inventory.size() < max_inventory_size:
				inventory.append(area.get_parent().items[area.get_parent().is_item])
				area.get_parent().queue_free()
			else:
				pass






