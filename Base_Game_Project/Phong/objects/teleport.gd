extends Area2D

export(String, FILE) var scene_path = ""
#export(Vector2) var spawn_loc = Vector2.ZERO


func _on_teleport_body_entered(body):
	Global.curr_scn = scene_path
	#Global.init_position = spawn_loc
	FadeEffect.scene_change(scene_path, "fade")
	#get_tree().change_scene(scene_path)
