extends Node

const MAX_SPELL = 5
var init_position = Vector2(224, 448)

var init_spells = {
	0: ["base"]
}

var spells = init_spells
var global_item_flags = false

func add_spell(name):
	for i in range(MAX_SPELL):
		if spells.has(i) == false:
			spells[i] = [name]
			return

func re_init():
	spells.clear()
	global_item_flags = true
	spells = {0: ["base"]}
	SpellInventory.init_spells_inv()

func debug_global():
	print("debug")
	return
