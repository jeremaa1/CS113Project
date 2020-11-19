extends KinematicBody2D


const GRAVITY = 20
export var speed = 100
const UP = Vector2(0, -1)
var motion = Vector2()
var direction = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	motion.x = speed * direction
	if direction == 1:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
		
	$AnimatedSprite.play("run")
	
	motion.y += GRAVITY
	motion = move_and_slide(motion, UP)

	if is_on_wall():
		direction = direction * -1
		if direction == 1:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
		$RayCast2D.position.x*= -1

	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		if direction == 1:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
		$RayCast2D.position.x*= -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
