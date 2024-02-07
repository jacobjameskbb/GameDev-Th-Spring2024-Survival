extends CharacterBody2D

var speed = 20000

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
