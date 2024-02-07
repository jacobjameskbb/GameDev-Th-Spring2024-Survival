extends Node

@onready var inventory_item_scene = preload('res://inventory_item.tscn')

@onready var Player = get_node('/root/BaseGame/Player')

@onready var item_sprites: Dictionary = {
	'Plank' : preload("res://Assets/Sprites/plank of wood.png")
	
	
	
	
	
	
}

@onready var list_of_resources_sprites: Dictionary = {
	'Plank' : preload("res://Assets/Sprites/plank of wood.png")
	
	
	
	
	
}

@onready var items_sprites: Dictionary = {
	
	
	
	
	
}

#is in the city or not
var in_city = false







