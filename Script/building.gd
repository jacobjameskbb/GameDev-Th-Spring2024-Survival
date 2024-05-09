extends Sprite2D

var health: int = 100

var building_type

func _ready():
	get_parent().island_area.remove_at(get_parent().island_area.find(position))

	get_parent().building_positions.append(position)

	$StaticBody2D/CollisionShape2D.shape = Global.dictionary_of_building_shapes[building_type]['Shape'].new()
	$StaticBody2D/CollisionShape2D.shape.size = Global.dictionary_of_building_shapes[building_type]['Size']
	$Area2D/CollisionShape2D.shape = Global.dictionary_of_building_shapes[building_type]['Shape'].new()
	$Area2D/CollisionShape2D.shape.size = Global.dictionary_of_building_shapes[building_type]['Size']

	if building_type == 'Crafting Table':
		var new_crafting_area = Area2D.new()
		var new_crafting_area_collision = CollisionShape2D.new()
		new_crafting_area.add_child(new_crafting_area_collision)
		new_crafting_area.add_to_group('Crafting_area')
		new_crafting_area_collision.shape = Global.dictionary_of_building_shapes[building_type]['Crafting_range_shape'].new()
		new_crafting_area_collision.shape.radius = Global.dictionary_of_building_shapes[building_type]['Crafting_radius']
		self.add_child(new_crafting_area)

	health = Global.dictionary_of_items[building_type]['Health']

func _process(_delta):
	
	if health <= 0:
		get_parent().island_area.append(position)
		
		get_parent().building_positions.remove_at(get_parent().building_positioins.find(position))
		
		self.queue_free()
	
	
