extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var damage = 15
export var coolDownTime = 1.0
var playerInRange = false
var player = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Thorn_Bush_body_entered(body):
	if 'Player' in body.name:
		playerInRange = true
		player = body
		player.take_damage(damage) # Player takes inital damage when hit the bush
		$Timer.start(coolDownTime)


func _on_Thorn_Bush_body_exited(body):
	playerInRange = false
	player = null
	$Timer.stop()


func _on_Timer_timeout():
	if playerInRange:
		player.take_damage(damage) # Player takes damage over time
		
