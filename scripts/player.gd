extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 0.1
const DECELERATION = 0.1
var gravityAcc := 1.0 # 0-1 is low gravity
var firstLanding = false


@onready var fade : CanvasLayer = $"../Fade"
@onready var gc := $Grapple

func _physics_process(delta: float) -> void:

	
	if is_on_floor() and not firstLanding:
		firstLanding = true
		gravityAcc = 0.8
		fade.queue_free()
	
	# Add the gravity.
	if not is_on_floor():
		var g = get_gravity()
		g = Vector2(g.x, g.y * gravityAcc) #change acceleration of gravity
		velocity += g * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() || gc.launched):
		velocity.y += JUMP_VELOCITY
		gc.release()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction and is_on_floor():
		$AnimatedSprite2D.play('walk')
	else:
		$AnimatedSprite2D.play("idle")
	
	if direction > 0:
		$AnimatedSprite2D.flip_h = false
	elif direction < 0:
		$AnimatedSprite2D.flip_h = true
	
	if direction:
		velocity.x = lerp(velocity.x, SPEED * direction, ACCELERATION)
		#walking sounds
		if $WalkTimer.time_left <= 0 and is_on_floor():
			$AudioStreamPlayer2D.pitch_scale = randf_range(0.8, 1.2)
			$AudioStreamPlayer2D.play()
			$WalkTimer.start(0.2)
	else:
		velocity.x = lerp(velocity.x, 0.0, DECELERATION)

	move_and_slide()
