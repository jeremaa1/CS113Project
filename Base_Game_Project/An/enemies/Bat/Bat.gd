extends KinematicBody2D

const UP = Vector2(0, -1)
var motion = Vector2()
var direction = -1
export var walkrange = 300
export var speed = 200
export var health = 100
onready var lowBound = self.position.x - walkrange/2
onready var upBound = lowBound + walkrange
var gravity = 20
const DEADDELAY = 1.0
signal update_health(health)
signal char_died()
var dead = false
func _physics_process(delta):
	if dead:
		$AnimatedSprite.play("destroyed")
		motion.x = 0
		motion.y += gravity
		motion = move_and_slide(motion, UP)
		if is_on_floor():
			set_physics_process(false)
			$CollisionShape2D.set_deferred("disabled", true)
			$DeadTimer.start(DEADDELAY)
	else:
		motion.x = speed * direction
		#print(self.position.x)
		
		# Restrict the character to move withn the "walkrange"
		if self.position.x < lowBound:
			self.position.x += 20
			direction *= -1
		if self.position.x > upBound:
			self.position.x -= 20
			direction *= -1
		# End restriction
		
		if direction == 1:
			$AnimatedSprite.flip_h = true 	# The bat sprite is facing left
											# it is opposite to the others
		else:
			$AnimatedSprite.flip_h = false
			
		$AnimatedSprite.play("run")
		if is_on_wall():
			direction *= -1
			motion.x = speed * direction
		motion = move_and_slide(motion)

func take_damage(value, spell):
	_set_health(health-value)
	
func dead():
	dead = true
	
	#queue_free()
	
func _set_health(value):
	var prev_health = health
	health = value
	print("Enemy Health: ", health)
	if health != prev_health:
		emit_signal("update_health", health)
		if health <= 0:
			dead()
			emit_signal("char_died")


func _on_DeadTimer_timeout():
	queue_free()
