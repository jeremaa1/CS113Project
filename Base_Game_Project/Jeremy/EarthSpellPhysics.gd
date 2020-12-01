extends RigidBody2D

var direction = 1
#1 is right, -1 is left
var timer = 0.0
var timer_active = false
const TIMER_TIME = 4 # in seconds

func _ready():
	pass # Replace with function body.

func set_direction(dir):
	direction = dir
	linear_velocity.x *= dir

func _process(delta):
	if (timer_active):
		timer -= delta
		if (timer <= 0):
			if abs(float(linear_velocity.x)) > 300 or abs(float(linear_velocity.y)) > 100:
				timer = 1
			else:
				timer_active = false
				queue_free()
func start_timer():
	if (timer_active == true):
		return # don't start the timer twice!
	timer = TIMER_TIME
	timer_active = true


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()	#Deletes the object when it moves offscreen
	"""
	Look into queue_free()
	consider using a temp. timer to count 2 secs
	and then delete the spell
	"""


func _on_EarthSpellPhysics_body_entered(body):
	#ADDED
	if abs(float(linear_velocity.x)) > 600 or linear_velocity.y < -200:
		if "Enemy" in body.name:
			body.take_damage((100 * Global.multiplier), "earth")
		if "Player" in body.name:
			body.take_damage(20)
