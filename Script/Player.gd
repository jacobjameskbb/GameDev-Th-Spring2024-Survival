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

var moving_items = false

var in_crafting_area = false

var dead = false

func get_input(delta):
	
	if Input.is_action_just_released("minimenu") and not dead:
		open_craft_menu()
	
	if not building and not crafting and not dead and not moving_items:
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
	$HealthBar.value = health
	
	if health <= 0:
		self.death()
	
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

func death():
	self.visible = false
	dead = true

func move_item(item, in_storage):
	if in_storage == false:
		inventory[item] += -1
		
		for child in $MiniMenu/TabContainer/Inventory/ScrollContainer/ItemGridContainer.get_children():
			if child.is_item == item:
				child.item_amount += -1
				current_amount_of_items += -1
				break
		
		var has_item_node = false
		
		for child in $GolfCartInventory/ScrollContainer/GridContainer.get_children():
			if child.is_item == item:
				child.item_amount += 1
				
				has_item_node = true
				
				break
		
		if has_item_node == false:
			var new_golfcart_inventory_item = Global.inventory_item_scene.instantiate()
			
			new_golfcart_inventory_item.is_item = item
			new_golfcart_inventory_item.in_storage = true
			$GolfCartInventory/ScrollContainer/GridContainer.add_child(new_golfcart_inventory_item)
	
	if in_storage and current_amount_of_items < max_inventory_size:
		for child in $GolfCartInventory/ScrollContainer/GridContainer.get_children():
			if child.is_item == item:
				child.item_amount += -1
				break
		
		var has_item_node = false
		
		current_amount_of_items += 1
		
		for child in $MiniMenu/TabContainer/Inventory/ScrollContainer/ItemGridContainer.get_children():
			if child.is_item == item:
				child.item_amount += 1
				inventory[item] += 1
				has_item_node = true
				break
		
		if has_item_node == false:
			var new_inventory_item = Global.inventory_item_scene.instantiate()
			inventory[item] = 1
			
			new_inventory_item.is_item = item
			
			$MiniMenu/TabContainer/Inventory/ScrollContainer/ItemGridContainer.add_child(new_inventory_item)

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
