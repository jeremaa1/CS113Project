extends Area2D

export var the_sprite = ""
export var spell_name = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.texture = load(the_sprite)
	

func _on_spellItem_body_entered(body):
	Global.add_spell(spell_name)
	SpellInventory.init_spells_inv()
	queue_free()
	
