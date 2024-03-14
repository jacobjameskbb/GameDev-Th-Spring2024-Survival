extends Sprite2D

var only_city: Array = [
	'Scrap pile',
	
]

var only_beach: Array = [
	'Palm tree'
]

@onready var resource_scene = preload("res://resource.tscn")

var is_object

var max_health = 200

var hit_points = 200

var is_on_beach = false

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
			position += Vector2(0,-16)
			scale.y *= 2
			scale.x += 0.25
			for child in get_children():
				child.scale.y /= 2
				child.scale.x -= 0.25
			$StaticBody2D/CollisionShape2D.shape.size.y = 20
			$StaticBody2D/CollisionShape2D.shape.size.x = 16
			$StaticBody2D.global_position += Vector2(0,16)
			$Button.global_position += Vector2(0,16)
			$ProgressBar.position = Vector2(-12.5,16)
			$ProgressBar.size = Vector2(32,2)
			$ProgressBar.scale = Vector2(0.825,0.5)

		if Global.objects['Rock'] == is_object:
			hit_points *= 2
			max_health *= 2
			$StaticBody2D/CollisionShape2D.shape = CircleShape2D.new()
			$StaticBody2D/CollisionShape2D.shape.radius = 9.5
			$StaticBody2D/CollisionShape2D.position.y += 1

	else:
		is_object = Global.objects['Palm tree']
		position += Vector2(0,-16)
		scale.y *= 2
		for child in get_children():
			child.scale.y /= 2
		$StaticBody2D/CollisionShape2D.shape.size.y = 20
		$StaticBody2D/CollisionShape2D.shape.size.x = 16
		$StaticBody2D.global_position += Vector2(0,16)
		$Button.global_position += Vector2(0,16)
		$ProgressBar.position = Vector2(-16,16)

	texture = is_object
	$ProgressBar.max_value = hit_points

func _process(_delta):
	if hit_points <= 0:
		var new_resource = resource_scene.instantiate()
		get_node('/root/BaseGame').add_child(new_resource)
		new_resource.position = position
		if Global.objects['Tree'] == is_object:
			new_resource.spawn_in('tree')
		if Global.objects['Rock'] == is_object:
			new_resource.spawn_in('rock')
		if Global.objects['Scrap pile'] == is_object:
			new_resource.spawn_in('scrap pile')
		if Global.objects['Palm tree'] == is_object:
			new_resource.spawn_in('palm tree')

		if Global.objects['Tree'] == is_object:
			get_node('/root/BaseGame').island_area.append(position + Vector2(0,16))
		else:
			get_node('/root/BaseGame').island_area.append(position)
		queue_free()

	if hit_points != max_health and $ProgressBar.visible == false:
		$ProgressBar.visible = true

	if hit_points != $ProgressBar.value:
		$ProgressBar.value = hit_points

func _on_button_button_up():
	if Global.Player.mouse_in_area:
		take_damage()

func take_damage():
	await get_node('/root/BaseGame/Player').get_child(3).animation_finished
	if Global.objects['Tree'] == is_object or Global.objects['Palm tree'] == is_object:
		if Global.Player.item_equipped == 'Axe':
			hit_points += -10
	if Global.objects['Rock'] == is_object:
		if Global.Player.item_equipped == 'Pickaxe':
			hit_points += -10
