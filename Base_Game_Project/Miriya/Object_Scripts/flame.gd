extends RigidBody2D

var motion = Vector2()

onready var burn_timer = $Burn_Timer
 

# Called when the node enters the scene tree for the first time.
func _ready():
	gravity_scale = 3
	contact_monitor = true
	contacts_reported = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):	
	pass


func _on_flame_body_entered(body):
	if body.name == 'player':
		body.take_damage(10)
		queue_free()
	else:
		if burn_timer.is_stopped():
			burn_timer.start()
			

func _on_Burn_Timer_timeout():
	queue_free() 
