extends CanvasLayer

onready var AnimationN = $Control/AnimationPlayer
var scene : String

func _ready():
	visible_off()

func scene_change(new_s, ani):
	for node in get_children():
		node.visible = true
	scene = new_s
	AnimationN.play(ani)

func new_scene():
	get_tree().change_scene(scene)
	yield(get_tree().create_timer(1.0), "timeout")
	visible_off()

func visible_off():
	for node in get_children():
		node.visible = false
