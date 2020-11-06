extends CanvasLayer

onready var spell_slots = $Control

func _ready():
	init_spells_inv()

func init_spells_inv():
	var slots = spell_slots.get_children()
	for i in range(slots.size()):
		if Global.spells.has(i):
			slots[i].init_spell(Global.spells[i][0])

func reveal_inv():
	for node in get_children():
		node.visible = true

func hide_inv():
	for node in get_children():
		node.visible = false
