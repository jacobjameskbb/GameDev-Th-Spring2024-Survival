extends Control

@export var item: String

func _ready():
	$TextureButton.texture_normal = Global.item_sprites[item]

func craft_item():
	for resource_needed in Global.dictionary_of_items[item]['Cost'].keys():
		if Global.Player.inventory[resource_needed] >= Global.dictionary_of_items[item]['Cost'][resource_needed]:
			print('ding')
			
			
			
			

func _on_texture_button_up():
	craft_item()
