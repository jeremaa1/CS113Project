#Player_V2

#This script adds the ability to shoot magic
#Hopefully

extends KinematicBody2D

signal update_health(health)
signal char_died()

onready var health_bar = $HealthBar/HealthBar
export (float) var max_health = 100

onready var health = max_health setget _set_health


const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = -550
var motion = Vector2()

#Loads the BaseSpell object for optimization
const SPELL = preload("res://Jeremy/BaseSpell.tscn")
const FIRE_SPELL = preload("res://Jeremy/FireSpell.tscn")
const ICE_SPELL = preload("res://Jeremy/IceSpell.tscn")
const ELEC_SPELL = preload("res://Jeremy/ElecSpell.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("update_health", health)
		if health == 0:
			dead()
			emit_signal("char_died")
			
func dead():
	pass

func _physics_process(delta):
	motion.y += GRAVITY
	
	#Added a sign check on the 2d position,
	#moves it left and right with the character
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		if sign($Position2D.position.x) == -1:
			$Position2D.position.x *= -1
		
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1

	else:
		motion.x = 0
	
	# Basic set to J
	if Input.is_action_just_pressed("ui_shoot"):
		var spell = SPELL.instance()
		spell.set_direction(sign($Position2D.position.x))
		get_parent().add_child(spell)
		spell.position = $Position2D.global_position
	#End of spawning a spell instance
	
	# Fire set to K
	if Input.is_action_just_pressed("ui_shoot2"):
		if Global.spells.has(1):
			var fire_spell = FIRE_SPELL.instance()
			fire_spell.set_direction(sign($Position2D.position.x))
			get_parent().add_child(fire_spell)
			fire_spell.position = $Position2D.global_position
	#End of spawning a spell instance
	
	# Ice set to L
	if Input.is_action_just_pressed("ui_shoot3"):
		var ice_spell = ICE_SPELL.instance()
		ice_spell.set_direction(sign($Position2D.position.x))
		get_parent().add_child(ice_spell)
		ice_spell.position = $Position2D.global_position
	#End of spawning a spell instance
	
	# Elec set to ;
	if Input.is_action_just_pressed("ui_shoot4"):
		var elec_spell = ELEC_SPELL.instance()
		elec_spell.set_direction(sign($Position2D.position.x))
		get_parent().add_child(elec_spell)
		elec_spell.position = $Position2D.global_position
		
	
	
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
	motion = move_and_slide(motion, UP)
	#print(motion)
	pass


func _on_JPlayer_update_health(health):
	health_bar.value = health
