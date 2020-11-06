extends KinematicBody2D
const GRAVITY = 20
const SPEED = 100
const UP = Vector2(0, -1)

var motion = Vector2()
var direction = -1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	motion.x = SPEED * direction
	if direction == 1:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
	$AnimatedSprite.play("walk")
	
	motion.y += GRAVITY
	
	motion = move_and_slide(motion, UP)
	
	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x*= -1 # todo :: fix spinning bug
		
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		$RayCast2D.position.x*= -1 # todo :: fix spinning bug
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
