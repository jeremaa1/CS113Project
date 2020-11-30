extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var gravity = 20
const DEADDELAY = 1.0
#export var health = 50
export (float) var max_health = 100
export var shootRange = 300
export var projectileSpeed = 300
export var collisionDamage = 15
const SPELL = preload("res://An/enemies/FireBird/Fire_Projectile.tscn")
export var cooldown = 2.0
const ATTACK_ANIMATION = 0.5
const UP = Vector2(0, -1)
var motion = Vector2()
signal update_health(health)
signal char_died()
signal update_max_health(max_health)
export var flip = false

onready var health_bar = $HealthBar/HealthBar
onready var health = max_health setget _set_health

# Called when the node enters the scene tree for the first time.
func _ready():
	if flip == true:
		$AnimatedSprite.flip_h = true
		$Position2D.position.x *= -1
	set_physics_process(false)
	$AnimatedSprite.play("idle")
	$AttackCooldown.start(cooldown)
func _physics_process(delta):
	if dead:
		$AnimatedSprite.play("dead")
		$CollisionShape2D.position.y = -8 # align the colision box to fit the sprite
		motion.x = 0
		motion.y += gravity
		motion = move_and_slide(motion, UP)
		if is_on_floor():
			set_physics_process(false)
			$CollisionShape2D.set_deferred("disabled", true)
			$CollisionHitBox/CollisionShape2D.set_deferred("disabled", true)
			$DeadTimer.start(DEADDELAY)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func attack():
	$AnimatedSprite.play("attack")
	$AnimationTimer.start(.25)
	var spell = SPELL.instance()
	spell.set_direction(sign($Position2D.position.x))
	get_parent().add_child(spell)
	spell.position = $Position2D.global_position
	spell.init_variables(spell.position.x, shootRange, projectileSpeed)

func _on_AttackCooldown_timeout():
	attack()



func _on_AnimationTimer_timeout():
	$AnimatedSprite.play("idle")

func take_damage(value, spell):
	_set_health(health-value)
	
var dead = false
func dead():
	dead = true
	$AttackCooldown.stop()
	$AnimationTimer.stop()
	set_physics_process(true)
	
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


func _on_Enemy_FireBird_update_health(health):
	health_bar.value = health


func _on_Enemy_FireBird_update_max_health(max_health):
	health_bar.max_value = max_health 
	health_bar.value = max_health


func _on_CollisionHitBox_body_entered(body):
	if 'Player' in body.name:
		body.take_damage(collisionDamage)
