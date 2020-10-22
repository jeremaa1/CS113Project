extends Area2D

export(String, FILE) var scene_path = ""
export(Vector2) var spawn_loc = Vector2.ZERO


func _on_teleport_body_entered(body):
	Global.init_position = spawn_loc
	get_tree().change_scene(scene_path)
