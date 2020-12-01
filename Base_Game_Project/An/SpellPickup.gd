extends Area2D

export var spell_name = ""
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var spellNames = ['ice', 'lighting', 'fire', 'earth']

# Called when the node enters the scene tree for the first time.
func _ready():
	if spell_name in spellNames:
		$AnimatedSprite.play(spell_name)
	else:
		printerr('No "'+ spell_name+'" spell found')


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SpellPickup_body_entered(body):
	if 'Player' in body.name:
		for i in range(1, Global.MAX_SPELL):
			if Global.spells.has(i) == true:
				if str(Global.spells[i]) == "[" + spell_name + "]":
					queue_free()
					return
		
		Global.add_spell(spell_name)
		Global.assign_spell()
		SpellInventory.init_spells_inv()
		print(Global.spells)
		queue_free()
