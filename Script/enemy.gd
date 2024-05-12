extends CharacterBody2D

var attacking = false

var wandering = false

var can_see_player = false

var path: PackedVector2Array = []

var safe_velocity: Vector2 = Vector2(0,0)

var possible_targets: Array = []

var wandering_target_set = false

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

func _physics_process(delta):
#	if $RayCast2D.is_colliding():
#		can_see_player = false
#	else:
#		can_see_player = true
	
	for body in possible_targets:
		if is_instance_valid(body) == false:
			possible_targets.erase(body)
	
	for body in $LineOfSight.get_overlapping_bodies():
		if body not in possible_targets and body.is_in_group('Attackable'):
			possible_targets.append(body)
	
	for body in possible_targets:
		if body not in $LineOfSight.get_overlapping_bodies():
			possible_targets.erase(body)
	
	if possible_targets.is_empty() == false:
		var current_target = possible_targets[0]
		
		for btarget in possible_targets:
			print(current_target, ' /// ', current_target.global_position)
			print(self.position.distance_to(current_target.position))
			if self.position.distance_to(btarget.position) < self.position.distance_to(current_target.position):
				current_target = btarget
				print('ding')
		
		target = current_target
	else:
		target = null
	
	if target != null:
		wandering = false
		attacking = true
		$NavigationAgent2D.target_position = target.position
		if target in $AttackRange.get_overlapping_bodies():
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
	if ($AnimatedSprite2D.is_playing() and $AnimatedSprite2D.animation == "attacking") == false:
		$AnimatedSprite2D.play("attacking")
	
	target.health += -10
	

func _on_navigation_agent_2d_target_reached():
	wandering_target_set = false
