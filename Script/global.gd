extends Node

@onready var inventory_item_scene = preload('res://inventory_item.tscn')

@onready var Button_scene = preload("res://panel_button.tscn")

@onready var Player = get_node('/root/BaseGame/Player')

@onready var Mouse = get_node('/root/BaseGame/Mouse')

@onready var Building_scene = preload("res://building.tscn")

@onready var item_sprites: Dictionary = {
	'Plank' : preload("res://Assets/Sprites/plank of wood.png"),
	'Rock' : preload("res://Assets/Sprites/rock - Copy.png"),
	'Wooden Fence' : preload("res://Assets/Sprites/fence.png"),
	'Stone Fence' : preload("res://Assets/Sprites/cobblestone wall.png")
}

@onready var objects: Dictionary = {
	'Tree' : preload("res://Assets/Sprites/Tree.png"),
	'Rock' : preload("res://Assets/Sprites/rock.png"),
	'Scrap pile' : preload("res://Assets/Sprites/Scrap pile.png"),
	'Palm tree' : preload("res://Assets/Sprites/palm tree.png")
	
}

@onready var resource_scene = preload("res://resource.tscn")

@onready var item_scene = preload("res://item.tscn")

@onready var list_of_resources_sprites: Dictionary = {
	'Plank' : preload("res://Assets/Sprites/plank of wood.png"),
	'Rock' : preload("res://Assets/Sprites/rock - Copy.png"),
	'Scrap' : preload('res://Assets/Sprites/scrap.png')
	
}

var dictionary_of_building_shapes = {
	'Wooden Fence' : {'Shape' : RectangleShape2D, 'Size' : Vector2(32,32)},
	'Stone Fence' : {'Shape' : RectangleShape2D, 'Size' : Vector2(32,32)},
	
}

var dictionary_of_items: Dictionary = {
	'Wooden Fence' : {'Health' : 250, 'Cost' : {'Plank' : 1}, 'Time' : 1, 'Need_CTable' : false},
	'Stone Fence' : {'Health' : 350, 'Cost' : {'Plank' : 1, 'Rock' : 1}, 'Time' : 2, 'Need_CTable' : false},
	
}

var list_of_buildings: Array = [
	'Wooden Fence',
	'Stone Fence',
	
]

var list_of_items: Array = [
	
]

var list_of_resources: Array = [
	'Plank',
	'Rock',
	'Scrap',
	
]

var dictionary_of_item_actions: Dictionary = {
	'Wooden Fence' : ['Place', 'Drop'],
	'Stone Fence' : ['Place', 'Drop'],
	'Plank' : ['Drop'],
	'Rock' : ['Drop'],
	'GolfCart' : ['Travel to the city', 'Check storage']
}

#is in the city or not
var in_city = false

var current_time = 0

var after_noon = false

var day = 0
