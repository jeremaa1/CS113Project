extends Button


export var ref_path = ""



func _ready():
	connect("pressed", self, "_on_Button_Pressed")

func _on_Button_Pressed():
	if (ref_path != ""):
		FadeEffect.scene_change(ref_path, 'fade')
		#get_tree().change_scene(ref_path)
	else:
		get_tree().quit()

