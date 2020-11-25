extends TextureButton

export var ref_path = ""

func _ready():
	connect("pressed", self, "_on_Button_Pressed")

func _on_Button_Pressed():
	
	if ref_path == "res://Phong/UI/titleScreen.tscn":
		FadeEffect.scene_change(ref_path, 'fade')
		SpellInventory.clear_spells_inv()
		Global.curr_scn = null
		return
	
	if ref_path != "":
		if Global.curr_scn == null:
			Global.curr_scn = ref_path
		FadeEffect.scene_change(ref_path, 'fade')
		Global.re_init()
		print(Global.spells)
		SpellInventory.reveal_inv()
		Tutorial.tutorial_on = true
		Tutorial.tutorial_init()
		#get_tree().reload_current_scene()
		#get_tree().change_scene(ref_path)
	elif Global.curr_scn != null:
		FadeEffect.scene_change(Global.curr_scn, 'fade')
		SpellInventory.reveal_inv()
	else:
		Global.spells.clear()
		get_tree().quit()
