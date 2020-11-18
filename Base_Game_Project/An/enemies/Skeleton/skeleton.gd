extends KinematicBody2D
const GRAVITY = 20
const SPEED = 100
const UP = Vector2(0, -1)

signal update_health(health)
signal char_died()
signal update_max_health(max_health)

onready var health_bar = $HealthBar/HealthBar
export (float) var max_health = 100
export var attackDamage = 50
onready var health = max_health setget _set_health

var motion = Vector2()
var direction = -1

var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("update_max_health", max_health)  # Setting the max health of the skeleton to 150
	

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
		if direction == 1:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
		$RayCast2D.position.x*= -1
		$DetectRange/HitBox.position.x *= -1
		
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		if direction == 1:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
		$RayCast2D.position.x*= -1
		$DetectRange/HitBox.position.x *= -1
		
		
func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	print("Enemy Health: ", health)
	if health != prev_health:
		emit_signal("update_health", health)
		if health == 0:
			dead()
			emit_signal("char_died")
			
func dead():
	set_physics_process(false)
	#$CollisionShape2D.disabled = true
	#$DetectRange/HitBox.disabled = true
	$CollisionShape2D.set_deferred("disabled", true)
	$DetectRange/HitBox.set_deferred("disabled", true)
	$AnimatedSprite.play('dead')
	
func take_damage(value, spell):
	_set_health(health-value)
	

func _on_enemy_skeleton_update_health(health):
	health_bar.value = health


var playerInAttackRange = false 	
#this == true when player enters attack range
# == false when player exits attack range

var attacking = false 
#this == true when the character start attacking animation
# and false when it finish attacking animation

func _on_DetectRange_body_entered(body):
	#if health <= 0: return
	# TO DO: Need a new way to detect player 
	if body.name == 'player' and not attacking:
		player = body
	#if body is KinematicBody2D:
		#print(body.filename)
		#print(body)
		set_physics_process(false) # stop moving
		playerInAttackRange = true
		attacking = true
		$DetectRange/AttackSync.start(.5)
		$AnimatedSprite.play("attack")
		#print('enter dectect range')

func _on_DetectRange_body_exited(body):
	if body.name == 'player':
		playerInAttackRange = false
		player = null

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "dead":
		queue_free()
	elif $AnimatedSprite.animation == "attack":
		if not playerInAttackRange:
			attacking = false
			set_physics_process(true)
		else:
			$DetectRange/AttackSync.start(.5)



func _on_AttackSync_timeout():
	if playerInAttackRange:
		print("player takes dmg")
		player.take_damage(attackDamage)
	$DetectRange/AttackSync.stop()


func _on_Enemy_skeleton_update_max_health(max_health):
	health_bar.max_value = max_health 
	health_bar.value = max_health
