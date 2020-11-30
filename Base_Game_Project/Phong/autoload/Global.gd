extends Node

const MAX_SPELL = 5
#var init_position = Vector2(224, 448)

var init_spells = {
	0: ["base"]
}

var spells = init_spells
var obt_fire = false
var obt_ice = false
var obt_light = false
var obt_earth = false

var curr_scn = null

func add_spell(name):
	for i in range(1, MAX_SPELL):
		if spells.has(i) == false:
			spells[i] = [name]
			return

func assign_spell():
	for i in range(1, MAX_SPELL):
		if spells.has(i) == true:
			if str(spells[i]) == "[fire]":
				obt_fire = true
			elif str(spells[i]) == "[ice]":
				obt_ice = true
			elif str(spells[i]) == "[lighting]":
				obt_light = true
			elif str(spells[i]) == "[earth]":
				obt_earth = true

func re_init():
	obt_fire = false
	obt_ice = false
	obt_light = false
	obt_earth = false
	spells.clear()
	spells = {0: ["base"]}
	SpellInventory.init_spells_inv()

#func debug_global():
#	print("debug")
#	return
