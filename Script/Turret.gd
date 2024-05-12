extends Node2D

var attacking = false

var target

var firing = false

var health = 100

func _ready():
	pass

func _process(delta):
	
	if attacking == false:
		$TurretBarrel.rotation_degrees += 100 * delta
	else:
		$TurretBarrel.rotation_degrees = (target.position - self.position).get_angle()
	
	if $RayCast2D.is_colliding():
		if attacking and firing == false and $RayCast2D.get_collider().is_in_group('Enemy'):
			self.fire() 
	
	if target != null:
		$RayCast2D.target_position = -(position - target.position)

func fire():
	firing = true
	
	var timer = get_tree().create_timer(2)
	
	await timer.timeout
	
	var new_bullet = Global.bullet_scene.instantiate()
	new_bullet.position = self.position
	new_bullet.rotation = rotation
	get_node('/root/BaseGame').add_child(new_bullet)
	firing = false
