extends KinematicBody2D
const GRAVITY = 20
const SPEED = 100
const UP = Vector2(0, -1)

signal update_health(health)
signal char_died()

onready var health_bar = $HealthBar/HealthBar
export (float) var max_health = 100

onready var health = max_health setget _set_health

var motion = Vector2()
var direction = -1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	motion.x = SPEED * direction
	if direction == 1:
		$AnimatedSprite.flip_h = false
		
	else:
		$AnimatedSprite.flip_h = true
		
	$AnimatedSprite.play("walk")
	
	motion.y += GRAVITY
	
	motion = move_and_slide(motion, UP)
	
	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x*= -1 # todo :: fix spinning bug
		
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		$RayCast2D.position.x*= -1
		
		
func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("update_health", health)
		if health == 0:
			dead()
			emit_signal("char_died")
			
func dead():
	queue_free()
	
func take_damage(value):
	_set_health(health-value)
	

func _on_enemy_skeleton_update_health(health):
	health_bar.value = health


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
