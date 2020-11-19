extends Area2D

func _ready():
	pass # Replace with function body.


func _on_health_potion_body_entered(body):
	if body is KinematicBody2D:
		body.heal_character(25)
		queue_free()  # Removing the health potion after picked up
