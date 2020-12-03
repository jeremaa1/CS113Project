# Chasing Ghost
extends KinematicBody2D
###
signal update_health(health)
signal char_died()

onready var health_bar = $HealthBar/HealthBar
export (float) var max_health = 100
export (int) var hurt = 25

onready var health = max_health setget _set_health
####

const FLOOR = Vector2(0,-1)
var rng = RandomNumberGenerator.new()

onready var Player = get_parent().get_node("Player")
var velocity = Vector2()
var max_dist = 300
var react_time = 400
var x_next_dir = 0
var x_next_dir_time = 0
var y_next_dir = 0
var y_next_dir_time = 0
export (int) var x_direction = 0 # (-1, 0, 1)
export (int) var y_direction = 0 

#####
var is_dead = false
var ice = false
var freeze = false 
var old_velocity = velocity 
####


func _ready():
	print (get_parent())
	velocity.x = x_direction * 100
	velocity.y = y_direction * 100
	set_process(true) 
	$AnimatedSprite.play("hunt")
	
	
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


func set_dir(target_dir):
	if x_next_dir != target_dir:
		x_next_dir = target_dir
		x_next_dir_time = OS.get_ticks_msec() + react_time
		
func y_set_dir(target_dir):
	if y_next_dir != target_dir:
		y_next_dir = target_dir
		y_next_dir_time = OS.get_ticks_msec() + react_time
		
		
func _chase(delta):
	if ice :
		return 
		
	if Player.position.x < position.x :
		set_dir(-1)
	elif Player.position.x > position.x :
		set_dir(1)
	else:
		set_dir(0)

	if Player.position.y < position.y:
		y_set_dir(-1)
	elif Player.position.y > position.y:
		y_set_dir(1)
	else:
		y_set_dir(0)
	
	if OS.get_ticks_msec() > x_next_dir_time:
		x_direction = x_next_dir

	if OS.get_ticks_msec() > y_next_dir_time:
		y_direction = y_next_dir
	
	velocity.x = x_direction * 150
	velocity.y = y_direction * 150

	velocity = move_and_slide(velocity, Vector2(0,-1))


func _hunt():
	if ice :
		return 
		
	if is_on_wall() :
		x_direction = x_direction * -1
		velocity.x = x_direction * 100
	if is_on_floor() or is_on_ceiling():
		y_direction = y_direction * -1
		velocity.y = y_direction * 100
	
	velocity = move_and_slide(velocity , FLOOR)


func _physics_process(delta):
	if Player == null:
		return 
	
	if is_dead == false:
		var follow = true if abs(Player.position.x - position.x) <= max_dist else false

		if follow:
			_chase(delta)
		else:
			_hunt()



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
	$AnimatedSprite.play("hunt")

func take_damage(value, spell):
	if spell == "ice":
		freeze()
	if ice == true and spell == "fire":
		unfreeze()
		_set_health(health)
	else:
			_set_health(health - value)
	
func _on_Enemy_chasing_ghost_update_health(health):
	health_bar.value = health
	


func _on_Freeze_timer_timeout():
	ice = false
	velocity = old_velocity
	$AnimatedSprite.play("hunt")


func _on_DetectRange_body_entered(body):
	if "Player" in body.name:
		body.take_damage(hurt)

