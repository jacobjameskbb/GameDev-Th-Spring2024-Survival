extends CharacterBody2D

var attacking = false

var currently_attacking = false

var wandering = false

var can_see_player = false

var path: PackedVector2Array = []

var safe_velocity: Vector2 = Vector2(0,0)

var possible_targets: Array = []

var wandering_target_set = false

var health = 100

var target

const speed = 200

const accelaration = 5

@export var is_enemy = 0

func _ready():
	if is_enemy == 0:
		$CollisionShape2D.shape = CircleShape2D.new()
		$CollisionShape2D.shape.radius = 44
		$NavigationAgent2D.avoidance_enabled = false

func _on_navigation_agent_2d_velocity_computed(svelocity):
	safe_velocity = svelocity

func _process(_delta):
	if health <= 0:
		self.queue_free()

func _physics_process(delta):
	if $RayCast2D.is_colliding():
		can_see_player = false
	else:
		can_see_player = true
	
	if currently_attacking == false and get_child(is_enemy).is_playing() == false:
		get_child(is_enemy).play('default')
	
	for body in possible_targets:
		if is_instance_valid(body) == false:
			possible_targets.erase(body)
	
	for body in $RangeOfSight.get_overlapping_bodies():
		if body not in possible_targets and body.is_in_group('Attackable'):
			possible_targets.append(body)
	
	for body in possible_targets:
		if body not in $RangeOfSight.get_overlapping_bodies():
			possible_targets.erase(body)
	
	if possible_targets.is_empty() == false:
		var closest_target = possible_targets[0]
		
		for test_target in possible_targets:
			if self.position.distance_to(test_target.position) < self.position.distance_to(closest_target.position):
				closest_target = test_target
		
		target = closest_target
	
	elif can_see_player:
		target = Global.Player
	
	else:
		target = null
	
	if target != null:
		wandering = false
		attacking = true
		$NavigationAgent2D.target_position = target.global_position
		if (target in $AttackRange.get_overlapping_bodies()) == true and currently_attacking == false:
			attack()
	
	if wandering == true:
		if wandering_target_set == false:
			$NavigationAgent2D.target_position = get_node('/root/BaseGame').island_area[randi_range(0,get_node('/root/BaseGame').island_area.size() - 1)]
			wandering_target_set = true
	
	$RayCast2D.target_position = -(position - Global.Player.position)
	
	var direction = Vector2()
	direction = $NavigationAgent2D.get_next_path_position() - global_position
	direction = direction.normalized() 
	
	if safe_velocity == Vector2(0,0):
		velocity = velocity.lerp(direction * speed, accelaration * delta)
	else:
		velocity = velocity.lerp(safe_velocity.normalized() * speed, accelaration * delta)
	
	move_and_slide()
	
	if Vector2(Vector2i(self.position)) in path:
		path.remove_at(path.find(Vector2(Vector2i(self.position))))

func attack():
	if target != null:
		currently_attacking = true
		
		if (get_child(is_enemy).is_playing() and get_child(is_enemy).animation == "attacking") == false:
			get_child(is_enemy).play("attacking")
		
		await get_child(is_enemy).animation_finished
		
		if target != null:
			if is_enemy == 0:
				if target.is_in_group('Object'):
					target.health += -100
				else:
					target.health += -10
			else:
				target.health += -10
			
			if target.is_in_group('Object'):
				target.get_parent().destroyed_by_player = false
		
		currently_attacking = false

func _on_navigation_agent_2d_target_reached():
	wandering_target_set = false

func _on_range_of_sight_body_entered(body):
	if body not in possible_targets and body.is_in_group('Attackable'):
		possible_targets.append(body)

func _on_range_of_sight_body_exited(body):
	if body in possible_targets:
		possible_targets.erase(body)
