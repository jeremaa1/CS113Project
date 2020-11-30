extends KinematicBody2D

const SPEED = 300
const JUMP_FORCE = 500
const GRAVITY = 1000

var motion = Vector2()

onready var sprite = get_node("sprite")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	motion.x = 0
	
	# movement input
	if Input.is_action_pressed("move_right"):
		motion.x = SPEED
	if Input.is_action_pressed("move_left"):
		motion.x = -SPEED	
	
	# moving the sprite
	motion = move_and_slide(motion, Vector2.UP)
	
	# gravity
	motion.y += GRAVITY * delta
	
	# jump input
	if Input.is_action_just_pressed("jump") and is_on_floor():
		motion.y -= JUMP_FORCE 
	
	# sprite direction, flip
	if motion.x < 0:
		sprite.flip_h = true
	elif motion.x > 0:
		sprite.flip_h = false
		
	
