extends KinematicBody2D
# Character that the player controls

signal update_health(health)
signal char_died()

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = -500
var motion = Vector2()

export (float) var max_health = 100

onready var health = max_health setget _set_health
onready var invulnerability_timer = $InvulnerabilityTimer
onready var health_bar = $HealthBar/HealthBar


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
	else:
		motion.x = 0
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
	motion = move_and_slide(motion, UP)
	
func heal_character(value):
	if health != max_health:
		emit_signal("update_health", health)
		_set_health(health+value)
		print("health: ", health)
	else:
		# Character health is maxed
		pass
	

	
func take_damage(value):
	if invulnerability_timer.is_stopped():
		invulnerability_timer.start()
		$Invulnerable_Animation.play("Invulnerable")
		_set_health(health-value)
		print("Health: ", health)
		

func killed():
	print("character_died")
	queue_free()


func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("update_health", health)
		if health == 0:
			killed()
			emit_signal("char_died")
	

func _on_Player_update_health(health):
	health_bar.value = health
	


func _on_InvulnerabilityTimer_timeout():
	pass # Replace with function body.


