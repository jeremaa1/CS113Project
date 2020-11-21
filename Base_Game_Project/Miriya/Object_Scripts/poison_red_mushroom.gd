extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var playerInAttackRange = false
var emit_poison = false
var attackDamage = 10
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HitBox_body_entered(body):
	if body.name == 'Player' and emit_poison == false:
		playerInAttackRange = true
		player = body
		$HitBox/Poison_timer.start(.5)
		$AnimatedSprite.play('emit_poison')
		


func _on_HitBox_body_exited(body):
	if body.name == 'Player':
		playerInAttackRange = false
		player = null
	


func _on_Poison_timer_timeout():
	#if playerInAttackRange and player != null:
	#	print("player takes dmg")
	#	player.take_damage(attackDamage)
	$HitBox/Poison_timer.stop()
	


func _on_AnimatedSprite_animation_finished():
	if not playerInAttackRange:
		emit_poison = false
	else:
		if playerInAttackRange and player != null:
			print("player takes dmg")
			player.take_damage(attackDamage)
		$HitBox/Poison_timer.start(.5)
	$AnimatedSprite.stop()
