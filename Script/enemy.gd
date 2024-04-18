extends CharacterBody2D

var attacking = false

var wandering = false

var can_see_player = false

var path: PackedVector2Array = []

var safe_velocity: Vector2 = Vector2(0,0)

var set_wandering_target = false

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
	if $RayCast2D.is_colliding():
		can_see_player = false
		wandering = true
	else:
		can_see_player = true
		wandering = false
		$AnimatedSprite2D.play('default')

	if wandering == true:
		if set_wandering_target == false:
			$NavigationAgent2D.target_position = get_node('/root/BaseGame').island_area[randi_range(0,get_node('/root/BaseGame').island_area.size() - 1)]
			set_wandering_target = true

	$RayCast2D.target_position = -(position - Global.Player.position)

	var direction = Vector2()
	direction = $NavigationAgent2D.get_next_path_position() - global_position
	direction = direction.normalized() 

	if safe_velocity == Vector2(0,0):
		velocity = velocity.lerp(direction * speed, accelaration * delta)
	else:
		velocity = velocity.lerp(safe_velocity.normalized() * speed, accelaration * delta)

	move_and_slide()

func _on_navigation_agent_2d_target_reached():
	set_wandering_target = false
