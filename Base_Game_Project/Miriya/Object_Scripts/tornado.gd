extends KinematicBody2D

signal body_entered(body)
onready var movingAnimationPlayer = $Moving_Animation
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	movingAnimationPlayer.play("Tornado_Simple_Movement")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Tornado_body_body_entered(body):
	if body is KinematicBody2D:
		body.global_position.y += body.JUMP_HEIGHT * 1.5
