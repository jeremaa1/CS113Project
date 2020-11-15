extends CanvasLayer

onready var Ani = $Control/AnimationPlayer

func _ready():
	visible_off()

func play_effect():
	for node in get_children():
		node.visible = true
	Ani.play("flash")
	yield(get_tree().create_timer(1.0), "timeout")
	visible_off()

func visible_off():
	for node in get_children():
		node.visible = false
