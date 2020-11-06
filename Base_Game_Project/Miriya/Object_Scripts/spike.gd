extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_spike_body_entered(body):
	#var character = get_parent().get_parent().get_node("Player")
	#print(character.health)
	body.take_damage(10)
	
	
	
