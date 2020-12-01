extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player = null
const TORNADO = preload("res://An/Tornado2.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("Player")
	$TornadoTimer.start(3.0)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TornadoTimer_timeout():
	var tornado = TORNADO.instance()
	tornado.position.x = player.position.x + 1500
	tornado.position.y = player.position.y + 50

	add_child(tornado)
