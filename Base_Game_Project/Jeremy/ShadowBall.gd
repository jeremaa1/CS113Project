extends RigidBody2D

#1 is right, -1 is left
var timer = 0.0
var timer_active = false
const TIMER_TIME = 4 # in seconds

# const SBALL = preload("res://Jeremy/ShadowBall.tscn")

func _ready():
	pass # Replace with function body.

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


func _on_ShadowBall_body_entered(body):
	if "Player" in body.name:
		body.take_damage(20)
		queue_free()
