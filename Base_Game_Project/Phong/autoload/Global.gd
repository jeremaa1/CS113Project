extends Node


var init_position = Vector2(224, 448)

var init_spells = {
	0: ["icon1"]
}

var spells = init_spells

func add_spell(name):
	for i in range(4):
		if spells.has(i) == false:
			spells[i] = [name]
			return

func re_init():
	spells.clear()
	spells = init_spells
	SpellInventory.init_spells_inv()

func debug_global():
	print("debug")
	return
