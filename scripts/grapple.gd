extends Node2D

@export var rest_length = 50.0
@export var stiffness = 15.0
@export var damping = 1.0

@onready var player := get_parent()
@onready var ray := $RayCast2D
@onready var rope := $Line2D

var launched = false
var target: Vector2
var closest_node = null

func _process(delta: float) -> void:
	ray.look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("grapple"):
		launch()
		
		
	if Input.is_action_just_released("grapple"):
		release()
		
	if launched:
		handle_grapple(delta)
		update_target_position()
	
func launch():
	if ray.is_colliding():
		launched = true
		$AudioStreamPlayer2D.play()
		target = ray.get_collision_point()
		if ray.get_collider() in get_tree().get_nodes_in_group("grapple_targets"):
			closest_node = ray.get_collider()
		rope.show()
	
func find_closest_node(v:Vector2):
	closest_node = null
	var closest_distance = INF
	
	for node in get_tree().get_nodes_in_group("grapple_targets"):
		var distance = v.distance_to(node.global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_node = node
	
	if closest_node != null:
		target = closest_node.position
	else:
		print("No nodes found in group 'grapple_targets'")

func update_target_position():
	if closest_node != null:
		target = closest_node.global_position
	
func release():
	closest_node = null
	launched = false
	rope.hide()

func handle_grapple(delta):
	var target_dir = player.global_position.direction_to(target)
	var target_dist = player.global_position.distance_to(target)
	
	var displacement = target_dist - rest_length
	
	var force = Vector2.ZERO
	
	if displacement > 0:
		var spring_force_magnitude = stiffness * displacement
		var spring_force = target_dir * spring_force_magnitude
		
		var vel_dot = player.velocity.dot(target_dir)
		var damping = -damping * vel_dot * target_dir
		
		force = spring_force + damping
	
	player.velocity += force * delta
	update_rope()

func update_rope():
	rope.set_point_position(1, to_local(target))
