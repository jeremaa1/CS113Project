extends Panel


var itemScn = preload("res://Phong/objects/Item.tscn")
var item = null

func _ready():
#	if randi() % 2 == 0:
#		item = itemScn.instance()
#		add_child(item)
	pass

func init_spell(name):
	if item == null:
		item = itemScn.instance()
		add_child(item)
		item.set_spell(name)
	else:
		item.set_spell(name)
