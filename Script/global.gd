extends Node

@onready var inventory_item_scene = preload('res://inventory_item.tscn')

@onready var Player = get_node('/root/BaseGame/Player')

@onready var Mouse = get_node('/root/BaseGame/Mouse')

@onready var item_sprites: Dictionary = {
	'Plank' : preload("res://Assets/Sprites/plank of wood.png"),
	'Rock' : preload("res://Assets/Sprites/rubble.png"),
	'Wooden Fence' : preload("res://Assets/Sprites/fence.png"),
	
}

@onready var objects: Dictionary = {
	'Tree' : preload("res://Assets/Sprites/Tree.png"),
	'Rock' : preload("res://Assets/Sprites/rock.png"),
	'Scrap pile' : preload("res://Assets/Sprites/Scrap pile.png"),
	'Palm tree' : preload("res://Assets/Sprites/palm tree.png")
	
}

@onready var list_of_resources_sprites: Dictionary = {
	'Plank' : preload("res://Assets/Sprites/plank of wood.png"),
	'Rock' : preload("res://Assets/Sprites/rubble.png"),
	'Scrap' : preload('res://Assets/Sprites/scrap.png')
	
}

var dictionary_of_items: Dictionary = {
	'Wooden Fence' : {'Health' : 250, 'Cost' : {'Plank' : 3}, 'Time' : 20},
	'Stone Fence' : {'Health' : 350, 'Cost' : {'Plank' : 1, 'Rock' : 3}},
	
}

@onready var dictionary_of_fences: Dictionary = {
	'wooden_fence_side_view' : preload('res://Assets/Sprites/fence.png'),
	'wooden_fence_front_view' : preload('res://Assets/Sprites/fence right side.png')
	
}

var dictionary_of_item_actions: Dictionary = {
	'Wooden Fence' : ['Place', 'Drop'],
	'Stone Fence' : ['Place', 'Drop'],
	
	
	
	
	
	
	
	
	
	
}

#is in the city or not
var in_city = false

var current_time = 0

var after_noon = false

var day = 0
