extends Node

@onready var inventory_item_scene = preload('res://inventory_item.tscn')

@onready var Button_scene = preload("res://panel_button.tscn")

@onready var Player = get_node('/root/BaseGame/Player')

@onready var Mouse = get_node('/root/BaseGame/Mouse')

@onready var Building_scene = preload("res://building.tscn")

@onready var resource_scene = preload("res://resource.tscn")

@onready var item_scene = preload("res://item.tscn")

@onready var house_scene = preload("res://house.tscn")

@onready var enemy_scene = preload("res://enemy.tscn")

@onready var large_house = preload("res://Assets/Sprites/Abandoned house.png")

@onready var bullet_scene = preload("res://bullet.tscn")

@onready var turret_scene = preload("res://turret.tscn")

@onready var item_sprites: Dictionary = {
	'Plank' : preload("res://Assets/Sprites/plank of wood.png"),
	'Rock' : preload("res://Assets/Sprites/rock - Copy.png"),
	'Scrap' : preload("res://Assets/Sprites/scrap.png"),
	'Coconut' : preload('res://Assets/Sprites/coconut.png'),
	'Wooden Fence' : preload("res://Assets/Sprites/fence.png"),
	'Stone Fence' : preload("res://Assets/Sprites/cobblestone wall.png"),
	'Ammo' : preload("res://Assets/Sprites/Ammo.png"),
	'Crafting Table' : preload("res://Assets/Sprites/Crafting Table.png"),
	'Turret' : preload("res://Assets/Sprites/turret.png"),
}

@onready var objects: Dictionary = {
	'Tree' : preload("res://Assets/Sprites/Tree.png"),
	'Rock' : preload("res://Assets/Sprites/rock.png"),
	'Scrap pile' : preload("res://Assets/Sprites/Scrap pile.png"),
	'Palm tree' : preload("res://Assets/Sprites/palm tree.png"),
	
}

@onready var house_sprites = [
	preload("res://Assets/Sprites/building.png"),
	preload("res://Assets/Sprites/building 1.png"),
]

@onready var list_of_resources_sprites: Dictionary = {
	'Plank' : preload("res://Assets/Sprites/plank of wood.png"),
	'Rock' : preload("res://Assets/Sprites/rock - Copy.png"),
	'Scrap' : preload('res://Assets/Sprites/scrap.png'),
	'Coconut' : preload("res://Assets/Sprites/coconut.png"),
}


var types_of_enemies = 1

var dictionary_of_building_shapes: Dictionary = {
	'Wooden Fence' : {'Shape' : RectangleShape2D, 'Size' : Vector2(32,32)},
	'Stone Fence' : {'Shape' : RectangleShape2D, 'Size' : Vector2(32,32)},
	'Crafting Table' : {'Shape' : RectangleShape2D, 'Size' : Vector2(32,32), 'Crafting_range_shape' : CircleShape2D, 'Crafting_radius' : 48.0,}
}

var dictionary_of_enemy_stats: Dictionary = {
	0 : {'Shape' : CircleShape2D, 'Size' : 44, 'Attack_range' : 75, 'uses_first_collision_layer' : true, 'collision_offset' : Vector2(0,0)},
	
	1 : {'Shape' : CircleShape2D, 'Size' : 80, 'Attack_range' : 120, 'uses_first_collision_layer' : false, 'collision_offset' : Vector2(0,0)},
	
	2 : {'Shape' : CapsuleShape2D, 'Size' : Vector2(26,102), 'Attack_range' : 200, 'uses_first_collision_layer' : true, 'collision_offset' : Vector2(-27,-18)},
	
	
	
}

var dictionary_of_items: Dictionary = {
	'Wooden Fence' : {'Health' : 250, 'Cost' : {'Plank' : 2}, 'Time' : 2.0, 'Need_CTable' : false},
	'Stone Fence' : {'Health' : 450, 'Cost' : {'Plank' : 1, 'Rock' : 3}, 'Time' : 10.0, 'Need_CTable' : false},
	'Crafting Table' : {'Health' : 50, 'Cost' : {'Plank' : 3, 'Rock' : 2}, 'Time' : 10.0, 'Need_CTable' : false},
	'Turret' : {'Cost' : {'Plank' : 2, 'Rock' : 1, 'Scrap' : 3}, 'Time' : 10.0, 'Need_CTable' : false},
}

var list_of_buildings: Array = [
	'Wooden Fence',
	'Stone Fence',
	'Crafting Table',
]

var list_of_items: Array = [
	'Ammo',
]

var list_of_resources: Array = [
	'Plank',
	'Rock',
	'Scrap',
	'Coconut',
]

var dictionary_of_item_actions: Dictionary = {
	'Wooden Fence' : ['Place', 'Drop'],
	'Stone Fence' : ['Place', 'Drop'],
	'Plank' : ['Drop'],
	'Rock' : ['Drop'],
	'Scrap' : ['Drop'],
	'GolfCartB' : ['Travel to city', 'Check storage'],
	'GolfCartT' : ['Travel to base', 'Check storage'],
	'Crafting Table': ['Place','Drop'],
	'Turret' : ['Place','Drop'],
	'Ammo' : ['Drop'],
	'Coconut' : ['Drop']
}

#is in the city or not
var in_city = false

var current_time = 0

var current_day = 0

var after_noon = false

var day = 0
