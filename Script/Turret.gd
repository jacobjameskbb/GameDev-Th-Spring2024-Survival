extends Node2D

var attacking = false

var target

var firing = false

var hit_points = 100

var max_health = 100

var list_of_targets: Array = []

func _ready():
	get_parent().island_area.remove_at(get_parent().island_area.find(position))
	
	get_parent().building_positions.append(position)
	
	$TextureProgressBar.max_value = hit_points
	
	$TextureProgressBar.value = hit_points
	
	$StaticBody2D.health = max_health

func _process(delta):
	$TextureProgressBar.value = hit_points
	
	if hit_points <= 0:
		get_parent().island_area.append(self.position)
		get_parent().building_positions.remove_at(get_parent().building_positions.find(position))
		self.queue_free()
	
	if list_of_targets.is_empty() == false:
		attacking = true
	else:
		attacking = false
	
	for body in list_of_targets:
		if is_instance_valid(body) == false:
			list_of_targets.erase(body)
	
	if $RayCast2D.is_colliding():
		if attacking == true and firing == false and $RayCast2D.get_collider().is_in_group('Enemy'):
			self.fire()
	
	for body in $Area2D.get_overlapping_bodies():
		if body.is_in_group('Enemy'):
			list_of_targets.append(body)
	
	for body in list_of_targets:
		if body not in $Area2D.get_overlapping_bodies():
			list_of_targets.erase(body)
	
	if list_of_targets.is_empty() != true:
		var current_target = list_of_targets[0]
	
		for body in list_of_targets:
			if self.position.distance_to(body.position) < self.position.distance_to(current_target.position):
				current_target = body
	
		target = current_target
	
	if target != null:
		$RayCast2D.target_position = -(position - target.position)
		$TurretBarrel.rotation_degrees = (target.position - self.position).angle()
	
	if attacking == false:
		$TurretBarrel.rotation_degrees += 100 * delta

func fire():
	firing = true
	
	var timer = get_tree().create_timer(2)
	
	await timer.timeout
	
	var new_bullet = Global.bullet_scene.instantiate()
	new_bullet.position = self.position
	new_bullet.rotation = $TurretBarrel.rotation
	get_node('/root/BaseGame').add_child(new_bullet)
	firing = false
