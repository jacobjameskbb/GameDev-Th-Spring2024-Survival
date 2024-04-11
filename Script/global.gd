extends Node

@onready var inventory_item_scene = preload('res://inventory_item.tscn')

@onready var Player = get_node('/root/BaseGame/Player')

@onready var item_sprites: Dictionary = {
	'Plank' : preload("res://Assets/Sprites/plank of wood.png"),
	'Rock' : preload("res://Assets/Sprites/rubble.png"),
	'WoodFence' : preload("res://Assets/Sprites/fence.png"),
	
	
	
	
	
	
	
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
	'WoodFence' : {'Health' : 250, 'Cost' : {'Plank' : 3}, 'Time' : 20},
	'StoneFence' : {'Health' : 350, 'Cost' : {'Plank' : 1, 'Rock' : 3}},
	
	
	
	
	
	
	
	
}

@onready var dictionary_of_fences: Dictionary = {
	'wooden_fence_side_view' : preload('res://Assets/Sprites/fence.png'),
	'wooden_fence_front_view' : preload('res://Assets/Sprites/fence right side.png')
	
	
	
	
}

#is in the city or not
var in_city = false

var current_time = 0

var after_noon = false

var day = 0
