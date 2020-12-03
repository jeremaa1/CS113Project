extends CanvasLayer

var tutorial_on = true

func _ready():
	for node in get_children():
		node.visible = false
	

func _input(event):
	if tutorial_on == true and event.is_action_pressed("gameMenu"):
		for node in get_children():
			node.visible = false
			
		get_tree().paused = false
		tutorial_on = false
		
	if Global.play_audio == true:
		AudContainer.play_aud()
		Global.play_audio = false

func tutorial_init():
	yield(get_tree().create_timer(1.9), "timeout")
	get_tree().paused = true
	Global.play_audio = true
	for node in get_children():
		node.visible = true
	
func open_tutorial():
	for node in get_children():
		node.visible = true
