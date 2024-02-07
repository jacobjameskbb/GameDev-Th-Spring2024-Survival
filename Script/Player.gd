extends CharacterBody2D

var speed = 20000

@onready var inventory_item_scene = preload('res://inventory_item.tscn')

var inventory: Array = []

var max_inventory_size = 10

var item_equipped = 'Axe'

var axe_level = 1
var pickaxe_level = 1

var left_click = false

func get_input(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed * delta
	if Input.is_action_just_pressed('LMB'):
		left_click = true
	else:
		left_click = false

func _physics_process(delta):
	get_input(delta)
	move_and_slide()

func _process(_delta):
	for area in $ReachArea.get_overlapping_areas():
		if left_click == true:
			if area.get_parent().is_in_group('Pickup_able'):
				if area.get_parent().mouse_in_area == true:
					if inventory.size() < max_inventory_size:
						if area.get_parent().is_in_group('Resource'):
							if area.get_parent().is_resource not in inventory:
								inventory.append(area.get_parent().is_resource)
								var new_item = inventory_item_scene.instantiate()
								new_item.is_item = area.get_parent().is_resource
								get_node('/root/BaseGame/Camera/ToolBar/Inventory/ItemGridContainer').add_child(new_item)
							else:
								for child in get_node('/root/BaseGame/Camera/ToolBar/Inventory/ItemGridContainer').get_children():
									if child.is_item == area.get_parent().is_resource:
										child.item_amount += 1
						elif area.get_parent().is_in_group('Item'):
							if area.get_parent().is_item not in inventory:
								inventory.append(area.get_parent().is_item)
								var new_item = inventory_item_scene.instantiate()
								new_item.is_item = area.get_parent().is_item
								get_node('/root/BaseGame/Camera/ToolBar/Inventory/ItemGridContainer').add_child(new_item)
							else:
								for child in get_node('/root/BaseGame/Camera/ToolBar/Inventory/ItemGridContainer').get_children():
									if child.is_item == area.get_parent().is_item:
										child.item_amount += 1
						area.get_parent().queue_free()
			if area.get_parent().is_in_group('Object'):
				if area.get_parent().mouse_in_area == true:
					if area.get_parent().objects['Tree'] == area.get_parent().is_object:
						if item_equipped == 'Axe':
							print('wham')
							area.get_parent().hit_points += -10 * axe_level
