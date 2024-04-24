extends Sprite2D

var health: int = 100

var building_type

var placed_on: String

func _ready():
	if position in get_parent().island_area:
		get_parent().island_area.remove(position)
		placed_on = 'island'
	if position in get_parent().beach_area:
		get_parent().beach_area.remove(position)
		placed_on = 'beach'

	get_parent().building_positions.append(position)

func _process(_delta):
	if health <= 0:
		
		if placed_on == 'island':
			get_parent().island_area.append(position)
		if placed_on == 'beach':
			get_parent().beach_area.append(position)
		
		get_parent().building_positions.remove(position)
		
		self.queue_free()
