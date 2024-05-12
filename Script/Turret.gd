extends Node2D

var attacking = false

var target

var firing = false

var list_of_targets: Array = []

func _ready():
	pass

func _process(delta):
	
	if attacking == false:
		$TurretBarrel.rotation_degrees += 100 * delta
	else:
		target = list_of_targets[0]
		$TurretBarrel.rotation_degrees = (target.position - self.position).get_angle()
	
	if attacking and firing == false:
		self.fire() 

func fire():
	firing = true
	
	var timer = get_tree().create_timer(2)
	
	await timer.timeout
	
	var new_bullet = Global.bullet_scene.instantiate()
	new_bullet.position = self.position
	new_bullet.rotation = rotation
	get_node('/root/BaseGame').add_child(new_bullet)
	firing = false

func _on_detection_area_body_entered(body):
	if body.is_in_group('Enemy'):
		if body not in list_of_targets:
			list_of_targets.append(body)
	
	if list_of_targets.is_empty() != true:
		attacking = true

func _on_detection_area_body_exited(body):
	if body.is_in_group('Enemy'):
		if body in list_of_targets:
			list_of_targets.erase(body)
	
	if list_of_targets.is_empty() == true:
		attacking = false
