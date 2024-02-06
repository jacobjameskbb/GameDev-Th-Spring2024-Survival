extends CharacterBody2D

var speed = 20000

@onready var inventory_item_scene = preload('res://inventory_item.tscn')

var inventory: Array = []

var max_inventory_size = 10

func get_input(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed * delta

func _physics_process(delta):
	get_input(delta)
	move_and_slide()

	for area in $ReachArea.get_overlapping_areas():
		if area.get_parent().is_in_group('Pickup_able'):
			if area.mouse_entered() == true and Input.is_action_pressed('pickup'):
				if inventory.size() < max_inventory_size:
					inventory.append(area.get_parent().items[area.get_parent().is_item])
					area.get_parent().queue_free()
					var new_item = inventory_item_scene.instantiate()
					var is_item
					if area.get_parent().is_in_group('object'):
						is_item = area.get_parent().is_object
					elif area.get_parent().is_in_group('item'):
						is_item = area.get_parent().is_item
					
					get_node('/BaseGame/Camera/ToolBar/Inventory/GridContainer').add_child(new_item)






