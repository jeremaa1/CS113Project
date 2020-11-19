extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var initSpeed = 300 # The current speed of the player
var slowSpeed = 100

func _on_Tall_Grass_body_entered(body):
	if "Player" in body.name:
		#initSpeed = body.get_speed()
		body.set_speed(slowSpeed)


func _on_Tall_Grass_body_exited(body):
	if "Player" in body.name:
		body.set_speed(initSpeed)

