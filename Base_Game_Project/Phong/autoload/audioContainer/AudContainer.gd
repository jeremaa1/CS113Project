extends Node

var aud = load("res://Jeremy/Track1.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_aud():
	$aud.stream = aud
	$aud.play()

func stop_aud():
	$aud.playing = false
