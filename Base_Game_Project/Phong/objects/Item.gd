extends Node2D

#var spell_name = ""

func _ready():
	pass

func set_spell(name):
	#spell_name = name
	$TextureRect.texture = load("res://Phong/objects/spells_icon/" + name + ".png")
	
