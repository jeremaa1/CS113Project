# First Ghost
extends KinematicBody2D
signal update_health(health)
signal char_died()
onready var health_bar = $HealthBar/HealthBar
export (float) var max_health = 100
export (int) var hurt = 20
onready var health = max_health setget _set_health
const SPEED = 5
const FLOOR = Vector2(0,-1)
var velocity = Vector2()
var is_dead = false
var ice = false
var old_velocity = velocity 
var x_direction = -1 # left
var y_direction = 0

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

func _walk():
	if ice :
		return 	
	velocity.x = SPEED * x_direction 
	velocity = move_and_slide(velocity, FLOOR)

func _physics_process(delta):
	if is_dead == false:
		_walk()

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

func _on_Enemy_update_health(health):
	health_bar.value = health

func _on_Freeze_timer_timeout():
	ice = false
	velocity = old_velocity
	$AnimatedSprite.play("Walk")






func _on_FirstGhostDetectRange_body_entered(body):
	if "player" in body.name:
		body.take_damage(hurt)
