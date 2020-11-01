extends CanvasLayer



func _ready():
	visible_off()

func _input(event):
	if event.is_action_pressed("gameMenu"):
		for node in get_children():
			node.visible = !get_tree().paused
			
		get_tree().paused = !get_tree().paused

func _on_continue_pressed():
	get_tree().paused = false
	visible_off()
	
func _on_quit_pressed():
	_on_continue_pressed()
	AudContainer.stop_aud()
	get_tree().change_scene("res://Phong/menu/titleScreen.tscn")
	

func visible_off():
	for node in get_children():
		node.visible = false








