extends KinematicBody2D


signal update_health(health)
signal char_died()
signal update_max_health(max_health)

onready var health_bar = $HealthBar/HealthBar
export (float) var max_health = 100
export var collisionDamage = 10
onready var health = max_health setget _set_health

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play('default')
	emit_signal("update_max_health", max_health)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

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
	$AnimatedSprite.play('dead')
	FadeEffect.scene_change("res://Phong/UI/ending.tscn", "fade")

func take_damage(value, spell):
	_set_health(health-value)

func _on_EnemyDarkLord_update_health(health):
	health_bar.value = health

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "armreach":
		pass	# Attack with fire, earth, or shadow

func _on_EnemyDarkLord_update_max_health(max_health):
	health_bar.max_value = max_health 
	health_bar.value = max_health


func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		body.take_damage(collisionDamage)
