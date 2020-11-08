extends KinematicBody2D
signal update_health(health)
signal char_died()

onready var health_bar = $HealthBar/HealthBar
export (float) var max_health = 100

onready var health = max_health setget _set_health

const SPEED = 50
const FLOOR = Vector2(0,-1)
const X_MAX_TIME = 500
const Y_MAX_TIME = 500

var velocity = Vector2()

var is_dead = false
var ice = false
var freeze = false 
var old_velocity = velocity 
############

 
var x_direction = -1 # left
var y_direction = -1 # up
var x_time = 0
var y_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true) 
	$AnimatedSprite.play("Walk")
	
func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("update_health", health)
		if health == 0:
			dead()
			emit_signal("char_died")

func dead():
	print("dead called")
	is_dead = true
	velocity = Vector2(0,0)
	$AnimatedSprite.play("dead")
	#$CollisionShape2D.disabled = true
	$Timer.start()


func _float():
	
	if ice :
		return 
		
	velocity.x = SPEED * x_direction 
	x_time += 1
	velocity.y = SPEED * y_direction
	y_time += 1
	
	if x_direction == 1:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
	
	velocity = move_and_slide(velocity, FLOOR)
	
	if is_on_wall() :
		x_direction = x_direction * -1
	if is_on_floor() or is_on_ceiling():
		y_direction = y_direction * -1
		
	if x_time % (4 * X_MAX_TIME) == 0:
		x_time = 0
		x_direction = x_direction * -1
	if y_time %  Y_MAX_TIME == 0:
		y_time = 0
		y_direction = y_direction * -1



func _physics_process(delta):
	if is_dead == false:
		_float()
	

func _on_Timer_timeout():
	queue_free()
	
func freeze():
	ice = true
	
	old_velocity = velocity
	velocity = Vector2(0,0)
	$AnimatedSprite.play("freeze")
	$Freeze_timer.start()
	
	
	
func unfreeze():
	ice = false
	$AnimatedSprite.play("Walk")

func take_damage(value, spell):
	if spell == "ice":
		freeze()
	if ice == true and spell == "fire":
		unfreeze()
		_set_health(health)
	else:
			_set_health(health - value)
	print(health)
	

func _on_Enemy_update_health(health):
	health_bar.value = health


func _on_Freeze_timer_timeout():
	print("timed out ")
	ice = false
	velocity = old_velocity
	print(velocity)
	$AnimatedSprite.play("Walk")
