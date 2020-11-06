extends Control

onready var health_bar = $HealthBar

func _on_health_updated(health, value):
	health_bar.value = health
	
func _max_health_updated(max_health):
	health_bar.max_value = max_health


