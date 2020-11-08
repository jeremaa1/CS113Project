extends Area2D

const SPEED = 420
var velocity = Vector2()
var direction = 1
#1 is right, -1 is left

func _ready():
	pass # Replace with function body.

func set_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true

func _process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	$AnimatedSprite.play("fireshoot")


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()	#Deletes the object when it moves offscreen
	"""
	Look into queue_free()
	consider using a temp. timer to count 2 secs
	and then delete the spell
	"""

#Function makes spell destroy self on any form of collision
func _on_FireSpell_body_entered(body):
		#ADDED
	if "Enemy" in body.name:
		body.take_damage(50, "fire")
	#END 
	queue_free()
	
