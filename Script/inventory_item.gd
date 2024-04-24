extends Control

var is_item

var item_amount: int = 1

var mouse_in_area = false

func _ready():
	$Sprite.texture = Global.item_sprites[is_item]
	$Item_name.text = is_item

func _process(_delta):
	$Item_amount.text = str(item_amount)
	if mouse_in_area:
		if is_item in Global.dictionary_of_item_actions.keys() and Input.is_action_pressed("RMB"):
			get_node('/root/BaseGame/Panel').open(is_item)

func _on_sprite_mouse_entered():
	mouse_in_area = true

func _on_sprite_mouse_exited():
	mouse_in_area = false
