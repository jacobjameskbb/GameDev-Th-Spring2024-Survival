extends Node2D

var only_city: Array = [
	'Scrap pile',
	
]

var only_beach: Array = [
	'Palm tree'
]

var is_object

var max_health = 200

var hit_points = 200

var is_on_beach = false

var taking_damage = false

var destroyed_by_player = false

func _ready():
	if is_on_beach == false:
		var random_objects = []
		if Global.in_city == false:
			for i in Global.objects.keys():
				if i not in only_city and i not in only_beach:
					random_objects.append(i)
		else:
			for i in Global.objects.keys():
				if i in only_city:
					random_objects.append(i)
		is_object = Global.objects[random_objects[randi_range(0,random_objects.size() - 1)]]

		if Global.objects['Tree'] == is_object:
			$Sprite2D.position += Vector2(0,-16)
			$Sprite2D.scale.y += 1
			$Sprite2D.scale.x += 0.25
			$StaticBody2D/CollisionShape2D.scale = Vector2(0.5,0.75)

		if Global.objects['Rock'] == is_object:
			hit_points *= 2
			max_health *= 2
			$StaticBody2D/CollisionShape2D.shape = CircleShape2D.new()
			$StaticBody2D/CollisionShape2D.shape.radius = 9.5
			$Sprite2D.position.y += -1

	else:
		is_object = Global.objects['Palm tree']
		$Sprite2D.position += Vector2(0,-16)
		$Sprite2D.scale.y *= 2

	$StaticBody2D.fix_health()
	$Sprite2D.texture = is_object
	$ProgressBar.max_value = hit_points

func _process(_delta):
	if hit_points <= 0:
		if destroyed_by_player == true:
			var new_resource = Global.resource_scene.instantiate()
			get_node('/root/BaseGame').add_child(new_resource)
			new_resource.position = position - Vector2(16,16)
			if Global.objects['Tree'] == is_object:
				new_resource.spawn_in('Plank')
			if Global.objects['Rock'] == is_object:
				new_resource.spawn_in('Rock')
			if Global.objects['Scrap pile'] == is_object:
				new_resource.spawn_in('Scrap')
			if Global.objects['Palm tree'] == is_object:
				new_resource.spawn_in(random_palm_tree_drop())
		
		if Global.objects['Scrap pile'] == is_object:
			get_node('/root/BaseGame').city_area.append(position)
			get_node('/root/BaseGame').current_city_object_density += -1
		
		elif Global.objects['Palm tree'] == is_object:
			get_node('/root/BaseGame').current_beach_foliage += -1
			get_node('/root/BaseGame').beach_area.append(position)
		
		else:
			get_node('/root/BaseGame').island_area.append(position)
			get_node('/root/BaseGame').current_foliage += -1
		
		queue_free()
	
	if hit_points != max_health and $ProgressBar.visible == false:
		$ProgressBar.visible = true
	
	if hit_points != $ProgressBar.value:
		$ProgressBar.value = hit_points

func random_palm_tree_drop(): 
	var random_number = randi_range(0,1)
	if 1 == random_number:
		return 'Coconut'
	else:
		return 'Plank'

func _on_button_button_up():
	if Global.Player.mouse_in_area and Global.Player.get_child(3).is_playing() == false:
		if taking_damage == false:
			if Global.objects['Tree'] == is_object or Global.objects['Palm tree'] == is_object:
				if Global.Player.item_equipped == 'Axe':
					take_damage()
			if Global.objects['Rock'] == is_object or Global.objects['Scrap pile'] == is_object:
				if Global.Player.item_equipped == 'Pickaxe':
					take_damage()

func take_damage():
	
	taking_damage = true
	
	if Global.Player.item_equipped == 'Axe':
		if Global.objects['Tree'] == is_object or Global.objects['Palm tree'] == is_object:
			if get_node('/root/BaseGame/Player').get_child(3).is_playing() == false:
				get_node('/root/BaseGame/Player').get_child(3).play('chopping')
	
	if Global.Player.item_equipped == 'Pickaxe':
		if Global.objects['Rock'] == is_object or Global.objects['Scrap pile'] == is_object:
			if get_node('/root/BaseGame/Player').get_child(3).is_playing() == false:
				get_node('/root/BaseGame/Player').get_child(3).play('mining')
	
	await get_node('/root/BaseGame/Player').get_child(3).animation_finished
	
	if Global.objects['Tree'] == is_object or Global.objects['Palm tree'] == is_object:
		hit_points += -10 * Global.Player.axe_level
	
	if Global.objects['Rock'] == is_object or Global.objects['Scrap pile'] == is_object:
		hit_points += -10 * Global.Player.pickaxe_level
	
	destroyed_by_player = true
	taking_damage = false
