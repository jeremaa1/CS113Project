extends Node

onready var ball_timer = $BallTimer
var falling_ball_scene = preload("res://Jeremy/ShadowBall.tscn")

const TORNADO = preload("res://Jeremy/BossFire.tscn")
var player_position
var random_location_num
export var tornado_offset = 170
export var tornado_timer = 2.5

func _ready():
	random_location_num = RandomNumberGenerator.new()
	$TornadoTimer.start(tornado_timer)
	get_node("Player/Camera2D").current = false
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ball_timer.is_stopped():
		ball_timer.start()


func _on_BallTimer_timeout():
	var random_location_num = RandomNumberGenerator.new()
	var screen_dimensions = get_viewport().get_visible_rect().size
	var player_position = get_node("Player").position
	#print("player position: ", player_position)
	
	#print(screen_dimensions)
	var ball = falling_ball_scene.instance()
	ball.start_timer()
	random_location_num.randomize()
	var x_coord = random_location_num.randf_range(64, 1344)
	var y_coord = 128
	ball.position.x = x_coord
	ball.position.y = -1.5 * player_position.y
	add_child(ball)
	#print(fire.position)

func _on_TornadoTimer_timeout():
	player_position = get_node("Player").position
	random_location_num.randomize()
	
	var tornado = TORNADO.instance()
	tornado.position.y = random_location_num.randf_range(384, 620)
	tornado.position.x = player_position.x + 1500

	add_child(tornado)
