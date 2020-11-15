extends Node

onready var falling_fire_timer = $Fire_Falling_Timer
var falling_fire_scene = preload("res://Miriya/Object_Scripts/flame.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if falling_fire_timer.is_stopped():
		falling_fire_timer.start()


func _on_Fire_Falling_Timer_timeout():
		var random_location_num = RandomNumberGenerator.new()
		var screen_dimensions = get_viewport().get_visible_rect().size
		var player_position = get_node("player").position
		print("player position: ", player_position)
		
		print(screen_dimensions)
		var fire = falling_fire_scene.instance()
		random_location_num.randomize()
		var x_coord = random_location_num.randf_range(player_position.x/8, player_position.x + 1500)
		var y_coord = random_location_num.randf_range(-2 * player_position.y, -player_position.y)
		fire.position.x = x_coord
		fire.position.y = -1.5 * player_position.y
		add_child(fire)
		print(fire.position)
