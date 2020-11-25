extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var playerInRange = false
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_thorns_bush_body_entered(body):
	if body.name == 'Player':  
		# Ensures only the player is damaged
		playerInRange = true
		player = body
		player.take_damage(10)
		$ConstantDamageTimer.start(0.5)
		


func _on_ConstantDamageTimer_timeout():
	if playerInRange:
		player.take_damage(10)
	else:
		$ConstantDamageTimer.stop()


func _on_thorns_bush2_body_exited(body):
	playerInRange = false
	player = null
	
