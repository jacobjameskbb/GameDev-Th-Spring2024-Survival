extends CharacterBody2D

var speed = 15000

var inventory: Dictionary = {}

var max_inventory_size = 10

var current_amount_of_items = 0

var item_equipped

var health = 100

var axe_level = 10

var pickaxe_level = 10

var mouse_in_area = false

var building = false

var crafting = false

var in_crafting_area = false

func get_input(delta):
	
	if Input.is_action_just_released("minimenu"):
		open_craft_menu()
	
	if building == false and crafting == false:
		var input_direction = Input.get_vector("left", "right", "up", "down")
		
		if input_direction == Vector2(0,0):
			$AnimatedSprite2D.play('idle')
		
		if input_direction == Vector2(0,1):
			$AnimatedSprite2D.play('down')
		
		if input_direction == Vector2(1,0):
			$AnimatedSprite2D.play('right')
		
		if input_direction == Vector2(-1,0):
			$AnimatedSprite2D.play('left')
		
		if input_direction == Vector2(0,-1):
			$AnimatedSprite2D.play('up')
		
		velocity = input_direction * speed * delta
	else:
		velocity = Vector2(0,0)
		$AnimatedSprite2D.play('idle')

func _physics_process(delta):
	get_input(delta)
	move_and_slide()

func _process(_delta):
	
	mouse_in_area = false
	in_crafting_area = false
	
	for i in $Area2D.get_overlapping_areas():
		if i.is_in_group('Mouse'):
			mouse_in_area = true
		
		if i.is_in_group('Crafting_area'):
			in_crafting_area = true
		
	
	for i in inventory.keys():
		if inventory[i] <= 0:
			inventory.erase(i)

func _on_held_item_animation_finished():
	if $HeldItem.animation == 'mining':
		$HeldItem.animation = 'mining_default'
	if $HeldItem.animation == 'chopping':
		$HeldItem.animation = 'chopping_default'

func open_craft_menu():
	if $MiniMenu.visible:
		$MiniMenu.visible = false
	else:
		$MiniMenu.visible = true

func _on_quit_button_up():
	get_tree().quit()
