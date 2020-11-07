extends KinematicBody2D


var velocity = Vector2()

############
onready var Player = get_parent().get_node("Player")
var max_dist = 200
var grav = 10
var max_grav = 40
var react_time = 400
var x_next_dir = 0
var x_next_dir_time = 0
var target_player_dist = 0
####
var y_next_dir = 0
var y_next_dir_time = 0
####
############

 
var x_direction = 0 # left
var y_direction = 0 # up
var x_time = 0
var y_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true) 


func set_dir(target_dir):
	if x_next_dir != target_dir:
		x_next_dir = target_dir
		x_next_dir_time = OS.get_ticks_msec() + react_time
		
func y_set_dir(target_dir):
	if y_next_dir != target_dir:
		y_next_dir = target_dir
		y_next_dir_time = OS.get_ticks_msec() + react_time
		
		
func _chase(delta):
	
	if Player.position.x < position.x - target_player_dist:
		set_dir(-1)
	elif Player.position.x > position.x + target_player_dist:
		set_dir(1)
	else:
		set_dir(0)
		
	####
	if Player.position.y < position.y - target_player_dist:
		y_set_dir(-1)
	elif Player.position.y > position.y + target_player_dist:
		y_set_dir(1)
	else:
		y_set_dir(0)
	#####
		
	if OS.get_ticks_msec() > x_next_dir_time:
		x_direction = x_next_dir
		
	####
	if OS.get_ticks_msec() > y_next_dir_time:
		y_direction = y_next_dir
	####
	
	velocity.x = x_direction * 100
	
	####
	velocity.y = y_direction * 100

	velocity = move_and_slide(velocity, Vector2(0,-1))




func _physics_process(delta):
	
	var follow = true if abs(Player.position.x - position.x) <= max_dist else false
	#print(follow)
	
	if follow:
		_chase(delta)

