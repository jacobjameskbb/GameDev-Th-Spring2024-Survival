extends Node

@onready var inventory_item_scene = preload('res://inventory_item.tscn')

@onready var Player = get_node('/root/BaseGame/Player')

@onready var item_sprites: Dictionary = {
	'Plank' : preload("res://Assets/Sprites/plank of wood.png"),
	'Rock' : preload("res://Assets/Sprites/rubble.png")
	
	
	
	
	
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

@onready var items_sprites: Dictionary = {
	
	
	
	
	
}

#is in the city or not
var in_city = false

var current_time = 0

var after_noon = false

var day = 0
