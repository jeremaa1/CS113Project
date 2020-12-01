extends AnimatedSprite

func _ready():
	self.play("default")

func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		body.take_damage(10)
