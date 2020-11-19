extends CanvasLayer

onready var spell_slots = $Control

func _ready():
	init_spells_inv()

func init_spells_inv():
	var slots = spell_slots.get_children()
	for i in range(slots.size()):
		if Global.spells.has(i):
			if slots[i].get_child_count() == 0:
				slots[i].init_spell(Global.spells[i][0])

func reveal_inv():
	for node in get_children():
		node.visible = true

func hide_inv():
	for node in get_children():
		node.visible = false

func clear_spells_inv():
	var slots = spell_slots.get_children()
	for s in range(1, slots.size()):
		if slots[s].get_child_count() > 0:
			slots[s].remove_child(slots[s].get_child(0))
	
	
	#for s in spell_slots.get_children():
		#s.remove_child(s.get_child(0))
		#print(i.get_child(0))
