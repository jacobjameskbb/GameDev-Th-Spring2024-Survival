extends Sprite2D

var health: int = 100

var building_type

func _ready():
	get_parent().island_area.remove_at(get_parent().island_area.find(position))

	get_parent().building_positions.append(position)

	$StaticBody2D/CollisionShape2D.shape = Global.dictionary_of_building_shapes[building_type]['Shape'].new()
	$StaticBody2D/CollisionShape2D.shape.size = Global.dictionary_of_building_shapes[building_type]['Size']

	health = Global.dictionary_of_items[building_type]['Health']

func _process(_delta):
	if health <= 0:
		
		
		get_parent().island_area.append(position)
		
		get_parent().building_positions.remove_at(get_parent().building_positioins.find(position))
		
		self.queue_free()
