extends CharacterBody2D

var attacking = false

var wandering = false

var can_see_player = false

var path: PackedVector2Array = []

var safe_velocity: Vector2 = Vector2(0,0)

@export var is_enemy = 0

func _ready():
	if is_enemy == 0:
		$CollisionShape2D.shape = CircleShape2D.new()
		$CollisionShape2D.shape.radius = 44

	start_moving()

func start_moving():
	var timer = get_tree().create_timer(1)
	await timer.timeout
	$NavigationAgent2D.target_position = get_node('/root/BaseGame').island_area[randi_range(0,get_node('/root/BaseGame').island_area.size() - 1)]

func _physics_process(_delta):
	if $RayCast2D.is_colliding():
		can_see_player = false
		wandering = true
	else:
		can_see_player = true
		wandering = true
		$AnimatedSprite2D.play('default')

	if wandering == true and $NavigationAgent2D.is_target_reached():
		$NavigationAgent2D.target_position = get_node('/root/BaseGame').island_area[randi_range(0,get_node('/root/BaseGame').island_area.size() - 1)]

	$RayCast2D.target_position = -(position - Global.Player.position)

	move_and_collide(safe_velocity)

func _on_navigation_agent_2d_velocity_computed(svelocity):
	print(svelocity)
	safe_velocity = svelocity
