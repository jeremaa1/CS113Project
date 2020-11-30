extends KinematicBody2D


const GRAVITY = 20
export var speed = 100
var motion = Vector2()
export var direction = -1
var hurt = 10
var is_dead = false 

func _ready():
	pass
	
func kill():
	is_dead = true 
	$CollisionShape2D.set_deferred("disabled", true)
	$RatDetectRegion/CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite.play("dead")
	$Death_time.start()
	
func _physics_process(delta):
	if is_dead:
		return 
	motion.x = speed * direction
	if direction == 1:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
		
	$AnimatedSprite.play("run")
	
	motion.y += GRAVITY
	motion = move_and_slide(motion, Vector2(0,1))

	if is_on_wall():
		direction = direction * -1


func _on_RatDetectRegion_body_entered(body):
	if "Player" in body.name:
		body.take_damage(hurt)

func _on_Death_time_timeout():
	queue_free()
