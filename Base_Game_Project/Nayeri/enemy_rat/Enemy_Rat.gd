extends KinematicBody2D


const GRAVITY = 20
export var speed = 100
var motion = Vector2()
var direction = -1
var hurt = 10


func _ready():
	pass
	
func _physics_process(delta):
	print(motion.x)
	motion.x = speed * direction
	if direction == 1:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
#		$CollisionShape2D.position.x *= -1
		
	$AnimatedSprite.play("run")
	
	motion.y += GRAVITY
	motion = move_and_slide(motion, Vector2(0,1))

	if is_on_wall():
		direction = direction * -1


func _on_RatDetectRegion_body_entered(body):
	if "Player" in body.name:
		body.take_damage(hurt)
