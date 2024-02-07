extends Control

var is_item

var item_amount: int = 1

func _ready():
	$Sprite.texture = Global.item_sprites[is_item]

func _process(_delta):
	$Item_amount.text = str(item_amount)
