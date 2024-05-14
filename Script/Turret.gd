extends Node2D

var attacking = false

var target

var firing = false

var hit_points = 100

var list_of_targets: Array = []

func _ready():
	get_parent().island_area.remove_at(get_parent().island_area.find(position))

	get_parent().building_positions.append(position)

func _process(delta):
	
	for body in list_of_targets:
		if is_instance_valid(body) == false:
			list_of_targets.erase(body)
	
	if attacking == false:
		$TurretBarrel.rotation_degrees += 100 * delta
	else:
		$TurretBarrel.rotation_degrees = (target.position - self.position).get_angle()
	
	if $RayCast2D.is_colliding():
		if attacking and firing == false and $RayCast2D.get_collider().is_in_group('Enemy'):
			self.fire() 
	
	for body in $Area2D.get_overlapping_areas():
		if body.is_in_group('Enemy'):
			list_of_targets.append(body)
	
	for body in list_of_targets:
		if body not in $Area2D.get_overlapping_areas():
			list_of_targets.erase(body)
	
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
