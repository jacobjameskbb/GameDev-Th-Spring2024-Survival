extends StaticBody2D

var health = 0


func fix_health():
	health = get_parent().max_health

func _process(_delta):
	if health != get_parent().hit_points:
		if health > get_parent().hit_points:
			health = get_parent().hit_points
		else:
			get_parent().hit_points = health
	
