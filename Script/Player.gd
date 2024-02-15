extends CharacterBody2D

var speed = 15000

var inventory: Array = []

var max_inventory_size = 10

var item_equipped

var axe_level = 1
var pickaxe_level = 1

var mouse_in_area = false

func get_input(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed * delta

func _physics_process(delta):
	get_input(delta)
	move_and_slide()

func _process(_delta):
	var mouse_in_area_ = false
	for i in $Area2D.get_overlapping_areas():
		if i.is_in_group('Mouse'):
			mouse_in_area_ = true
	if mouse_in_area_ == true:
		mouse_in_area = true
	else:
		mouse_in_area = false
