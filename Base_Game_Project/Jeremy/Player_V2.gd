#Player_V2

#This script adds the ability to shoot magic
#Hopefully

extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = -550
var motion = Vector2()

#Loads the BaseSpell object for optimization
const SPELL = preload("res://Jeremy/BaseSpell.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	
	#Spell currently set to TAB
	if Input.is_action_just_pressed("ui_focus_next"):
		var spell = SPELL.instance()
		spell.set_direction(sign($Position2D.position.x))
		get_parent().add_child(spell)
		spell.position = $Position2D.global_position
	#End of spawning a spell instance
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
	motion = move_and_slide(motion, UP)
	print(motion)
	pass
