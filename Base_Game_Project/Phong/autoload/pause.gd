extends CanvasLayer



func _ready():
	visible_off()

func _input(event):
	if get_tree().get_current_scene().get_name() == "titleScreen":
		return
		
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
	SpellInventory.clear_spells_inv()
	#Tutorial.tutorial_on = true
	Global.curr_scn = null
	get_tree().change_scene("res://Phong/UI/titleScreen.tscn")	

func visible_off():
	for node in get_children():
		node.visible = false



func _on_TextureButton_pressed():
	visible_off()
	Tutorial.tutorial_on = true
	Tutorial.open_tutorial()	
