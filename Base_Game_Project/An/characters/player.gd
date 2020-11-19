extends KinematicBody2D

signal update_health(health)
signal char_died()

onready var invulnerability_timer = $InvulnerabilityTimer
onready var health_bar = $HealthBar/HealthBar
export (float) var max_health = 100

onready var health = max_health setget _set_health

const UP = Vector2(0, -1)
const GRAVITY = 25

const JUMP_HEIGHT = -650

const COOLDOWN = 300
const SPELL = preload("res://Jeremy/BaseSpell.tscn")
const FIRE_SPELL = preload("res://Jeremy/FireSpell.tscn")
const ICE_SPELL = preload("res://Jeremy/IceSpell.tscn")
const ELEC_SPELL = preload("res://Jeremy/ElecSpell.tscn")
const EARTH_SPELL = preload("res://Jeremy/EarthSpell.tscn")

# Make the speed a variable instead of a constant
# in order to slow down the player
var speed = 300
var motion = Vector2()
#onready var animationPlayer = $AnimationPlayer

var fired = OS.get_ticks_msec()

var is_attacking = false
var on_ground = false

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
	# Move functions
	if Input.is_action_pressed("ui_right"): 
		if not is_attacking or not is_on_floor():
			motion.x = speed
			if not is_attacking:
				$AnimatedSprite.flip_h = false
				$AnimatedSprite.play("run")
				if sign($Position2D.position.x) == -1:
					$Position2D.position.x *= -1
		
	elif Input.is_action_pressed("ui_left"):
		if not is_attacking or not is_on_floor():
			motion.x = -speed
			if not is_attacking:
				$AnimatedSprite.flip_h = true
				$AnimatedSprite.play("run")
				if sign($Position2D.position.x) == 1:
					$Position2D.position.x *= -1
			
	else:
		motion.x = 0
		if on_ground and not is_attacking:
			$AnimatedSprite.play("idle")
			
	if Input.is_action_just_pressed("ui_up") and not is_attacking and on_ground:
		motion.y = JUMP_HEIGHT	
		on_ground = false	
	# End move functions
	
	# Attack functions
	# Basic set to J
	if Input.is_action_just_pressed("ui_shoot") and can_fire() and not is_attacking:
		if is_on_floor():
			motion.x = 0
		is_attacking = true
		#SpellInventory.debug()
		$AnimatedSprite.play("attack")
		var spell = SPELL.instance()
		spell.set_direction(sign($Position2D.position.x))
		get_parent().add_child(spell)
		spell.position = $Position2D.global_position
	#End of spawning a spell instance
	
	# Fire set to K
	if Input.is_action_just_pressed("ui_shoot2") and can_fire() and not is_attacking:
		if Global.obt_fire == true:
			if is_on_floor():
				motion.x = 0
			is_attacking = true
			$AnimatedSprite.play("attack")
			var fire_spell = FIRE_SPELL.instance()
			fire_spell.set_direction(sign($Position2D.position.x))
			get_parent().add_child(fire_spell)
			fire_spell.position = $Position2D.global_position
	#End of spawning a spell instance
	
	# Ice set to L
	if Input.is_action_just_pressed("ui_shoot3") and can_fire() and not is_attacking:
		if Global.obt_ice == true:
			if is_on_floor():
				motion.x = 0
			is_attacking = true
			$AnimatedSprite.play("attack")
			var ice_spell = ICE_SPELL.instance()
			ice_spell.set_direction(sign($Position2D.position.x))
			get_parent().add_child(ice_spell)
			ice_spell.position = $Position2D.global_position
	#End of spawning a spell instance
	
	# Elec set to ;
	if Input.is_action_just_pressed("ui_shoot4") and can_fire() and not is_attacking:
		if Global.obt_light == true:
			if is_on_floor():
				motion.x = 0
			is_attacking = true
			$AnimatedSprite.play("attack")
			var elec_spell = ELEC_SPELL.instance()
			elec_spell.set_direction(sign($Position2D.position.x))
			get_parent().add_child(elec_spell)
			elec_spell.position = $Position2D.global_position
	
	# Earth set to I
	if Input.is_action_just_pressed("ui_shoot5") and can_fire() and not is_attacking:
		if Global.obt_earth == true:
			if is_on_floor():
				motion.x = 0
			is_attacking = true
			$AnimatedSprite.play("attack")
			var earth_spell = EARTH_SPELL.instance()
			earth_spell.set_direction(sign($Position2D.position.x))
			get_parent().add_child(earth_spell)
			earth_spell.position = $Position2D.global_position
	#End attack functions
	
	# Extra processing and animation
	motion.y += GRAVITY		
	if is_on_floor():
		if not on_ground:
			is_attacking = false
		on_ground = true 
	else:
		if not is_attacking:
			on_ground = false
			if motion.y > 0 :
				$AnimatedSprite.play("fall")
			else:
				$AnimatedSprite.play("jump")
		

	motion = move_and_slide(motion, UP)



func _on_player_update_health(health):
	health_bar.value = health

func can_fire():
	var attempt = OS.get_ticks_msec()
	if attempt - fired > COOLDOWN:
		fired = attempt
		return true
	return false


func take_damage(value):
	if invulnerability_timer.is_stopped():
		invulnerability_timer.start()
		$Invulnerable_Animation.play("Invulnerable")
		FlashEffect.play_effect()
		_set_health(health-value)
		print("Health: ", health)
		
func heal_character(value):
	if health != max_health:
		emit_signal("update_health", health)
		_set_health(health+value)
		print("health: ", health)
	else:
		# Character health is maxed
		pass


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "attack":
		is_attacking = false

func set_speed(newSpeed):
	speed = newSpeed
	
func get_speed():
	return speed
