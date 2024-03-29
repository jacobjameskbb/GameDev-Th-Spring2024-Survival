extends CharacterBody2D

var speed = 15000

var inventory: Array = []

var max_inventory_size = 10

var current_amount_of_items = 0

var item_equipped

var health = 100

var axe_level = 1

var pickaxe_level = 1

var mouse_in_area = false

var building = false

func get_input(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	if input_direction == Vector2(0,1):
		$AnimatedSprite2D.play('down')
	if input_direction == Vector2(0,0):
		$AnimatedSprite2D.play('idle')

	if Input.is_action_just_released("minimenu"):
		open_craft_menu()

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

func _on_held_item_animation_finished():
	if $HeldItem.animation == 'Mining':
		$HeldItem.animation = 'mining_default'
	if $HeldItem.animation == 'chopping':
		$HeldItem.animation = 'chopping_default'

func open_craft_menu():
	if $MiniMenu.visible:
		$MiniMenu.visible = false
	else:
		$MiniMenu.visible = true
	
	
	
	
	
	pass




