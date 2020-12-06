extends Area2D

export var the_sprite = ""
export var spell_name = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.texture = load(the_sprite)
	

func _on_spellItem_body_entered(body):
	
	for i in range(1, Global.MAX_SPELL):
		if Global.spells.has(i) == true:
			if str(Global.spells[i]) == "[" + spell_name + "]":
				queue_free()
				return
	
	Global.add_spell(spell_name)
	Global.assign_spell()
	SpellInventory.init_spells_inv()
	queue_free()
	
