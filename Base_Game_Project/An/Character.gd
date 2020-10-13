extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = -500

var motion = Vector2()
onready var animationPlayer = $AnimationPlayer
	
func _physics_process(delta):
	motion.y += GRAVITY
	if Input.is_action_pressed("ui_right"):
		$Sprite.flip_h = false
		animationPlayer.play("run")
		motion.x = SPEED
		
	elif Input.is_action_pressed("ui_left"):
		$Sprite.flip_h = true
		animationPlayer.play("run")
		motion.x = -SPEED
	else:
		animationPlayer.play("idle")
		motion.x = 0
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT	
	elif motion.y > 0:
		animationPlayer.play("free_fall")
	else:
		animationPlayer.play("jump")
	motion = move_and_slide(motion, UP)
	print(motion)
	pass
