extends Area2D


export var damage = 100

var player = null
var isInvulnerable = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_flame_body_entered(body):
	if 'Player' in body.name:
		player = body
		player.take_damage(damage) # Player takes inital damage when hit the bush
