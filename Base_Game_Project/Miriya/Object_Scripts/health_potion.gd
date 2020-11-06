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


func _on_health_potion_body_entered(body):
	if body is KinematicBody2D:
		body.heal_character(25)
		queue_free()  # Removing the health potion after picked up
