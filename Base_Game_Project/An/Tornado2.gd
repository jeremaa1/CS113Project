extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var motion = Vector2()
var direction = -1
var speed = 300
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play('idle')
	#$CollisionShape2D.disabled()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	motion.x = speed * direction
	motion = move_and_slide(motion)
func _on_Area2D_body_entered(body):
	if 'Player' in body.name:
		body.motion.y = body.JUMP_HEIGHT * 1.8
		body.take_damage(10)
		#body.global_position.y += body.JUMP_HEIGHT


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
