extends Node

signal update_health(value)
signal char_death

export (int) var max_health = 100 
onready var current_health = max_health setget set_health

func _ready():
	_init()

func _init():
	emit_signal("update_health", current_health)

func set_health(value):
	current_health = clamp(current_health, 0, max_health)
	emit_signal("update_health", current_health)
	
	if current_health == 0:
		emit_signal("char_death")

