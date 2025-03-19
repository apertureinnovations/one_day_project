extends CharacterBody2D

@onready var player = $AnimatedSprite2D
@export var gravity_strength = 980 # Default gravity value in Godot
@export var max_fall_speed = 1000 # Maximum falling speed

const SPEED = 100  # Normal movement speed
const SPRINT_MULTIPLIER = 1.8  # Sprinting speed multiplier
const JUMP_FORCE = -350  # Force applied when jumping

func _physics_process(delta):
	# Apply gravity
	
	if Input.is_action_pressed("exit"):
		get_tree().quit(-1)
	
	if not is_on_floor():
		velocity.y += gravity_strength * delta
		velocity.y = clamp(velocity.y, -max_fall_speed, max_fall_speed) # Limit falling speed
	
	# Reset horizontal velocity
	velocity.x = 0
	
	var move_speed = SPEED  # Default speed

	# Movement input
	if Input.is_action_pressed("move_right"):
		velocity.x += move_speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= move_speed
		
	# Jump input
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_FORCE  # Set jump velocity
	
	# Sprint input
	if Input.is_action_pressed("sprint"):
		velocity.x *= SPRINT_MULTIPLIER
		
	move_and_slide()

	# Handle animation and sprite flipping
	if velocity.x > 0:
		player.flip_h = true
	elif velocity.x < 0:
		player.flip_h = false
	
	if velocity.x != 0 and is_on_floor():
		player.play("left_right")
	else:
		player.play("idle")
