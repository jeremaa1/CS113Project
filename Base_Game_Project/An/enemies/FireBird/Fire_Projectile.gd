extends Area2D

var speed = 300
var velocity = Vector2()
var direction = 1 #1 is right, -1 is left
var travelRange = 500
var initX
var upBound
var lowBound

func init_variables(x, shootRange, projSpeed):
	speed = projSpeed
	travelRange = shootRange
	initX = x
	upBound = x + travelRange
	lowBound = x - travelRange

func _ready():
	pass

func set_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true
		$CollisionShape2D.position.x *= -1

func _process(delta):
	if not destroyed:
		velocity.x = speed * delta * direction
		translate(velocity)
		$AnimatedSprite.play("fireshoot")
		if self.position.x > upBound or self.position.x < lowBound:
			destroyed = true
	else:
		velocity.x = 0
		
		$AnimatedSprite.play("destroyed")


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()	#Deletes the object when it moves offscreen
	"""
	Look into queue_free()
	consider using a temp. timer to count 2 secs
	and then delete the spell
	"""

#Function makes spell destroy self on any form of collision
var destroyed = false
func _on_Fire_Projectile_body_entered(body):
	if "Enemy" in body.name: 
		return
	if "Player" in body.name:
		body.take_damage(20)
		queue_free()
	else:
		destroyed = true
	#END 
	
func dead():
	destroyed = true

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "destroyed":
		queue_free()


