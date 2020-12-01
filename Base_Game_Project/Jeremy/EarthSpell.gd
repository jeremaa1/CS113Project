extends Area2D

const SPEED = 700
var velocity = Vector2()
var direction = 1
#1 is right, -1 is left

func _ready():
	pass # Replace with function body.

func set_direction(dir):
	direction = dir

func _process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()	#Deletes the object when it moves offscreen
	"""
	Look into queue_free()
	consider using a temp. timer to count 2 secs
	and then delete the spell
	"""


func _on_EarthSpell_body_entered(body):
	#ADDED
	if "Enemy" in body.name:
		body.take_damage((50 * Global.multiplier), "earth")
	#END 
	queue_free()
