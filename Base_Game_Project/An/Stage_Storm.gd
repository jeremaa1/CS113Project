extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const TORNADO = preload("res://An/Tornado2.tscn")
var player_position
var random_location_num
export var tornado_offset = 170
export var tornado_timer = 2.5
# Called when the node enters the scene tree for the first time.
func _ready():
	random_location_num = RandomNumberGenerator.new()
	$TornadoTimer.start(tornado_timer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TornadoTimer_timeout():
	player_position = get_node("Player").position
	random_location_num.randomize()
	
	var tornado = TORNADO.instance()
	tornado.position.y = random_location_num.randf_range(player_position.y - tornado_offset, player_position.y + tornado_offset)
	tornado.position.x = player_position.x + 1500

	add_child(tornado)
