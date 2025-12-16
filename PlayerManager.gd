class_name GlobalPlayerManager
extends Node
var max_sides_player: int = 3
var sides_player: int = 0
var player_speed: int = 400
var player_acceleration: int = 1000
var player_acceleration_slow: int = 80
var player_max_speed: int = 1000
var player: Node2D = null
var currency: int = 1000
var game_paused = false
var player_max_health: int = 10
var room_activate = false
var player_pos: Vector2
var playerjumponenter: bool
var lobber_damage: int = 1
var max_health_sides_addition: bool = false
var does_player_emit_light: bool = false
var can_I_open_a_menu: bool = true
var collectable_count: int = 0
var starting_area = PROPERTY_USAGE_NODE_PATH_FROM_SCENE_ROOT
var scene
var player_max_speed_circle: int = 1500
var load_game_check: bool = false
var Collectable_array = [false, false, false, false, false, false, false, false, false, false, false, false, false, false]
func _ready() -> void:
	can_I_open_a_menu = true
	print("you can open a menu because the PlayerManager script was just loaded")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func save():
	var save_dict = {
		"max_sides_player" : max_sides_player,
		"sides_player" : sides_player,
		"player_speed" : player_speed,
		"player_acceleration" : player_acceleration,
		"player_acceleration_slow" : player_acceleration_slow,
		"player_max_speed" : player_max_speed,
		"currency" : currency,
		"game_paused" : game_paused,
		"player_max_health" : player_max_health,
		"room_activate" : room_activate ,
		"player_pos" : player_pos,
		"playerjumponenter" : playerjumponenter,
		"lobber_damage" : lobber_damage,
		"max_health_sides_addition" : max_health_sides_addition,
		"does_player_emit_light" : does_player_emit_light,
		"can_I_open_a_menu" : can_I_open_a_menu,
		"collectable_count" : collectable_count,
		"scene" : scene,
		"Collectable_array" : Collectable_array
	}
	return save_dict
	
# Note: This can be called from anywhere inside the tree. This function is
# path independent.
# Go through everything in the persist category and ask them to return a
# dict of relevant variables.
func save_game():
	var save_file = FileAccess.open("res://ShapesMetroidvania.save", FileAccess.WRITE)
	var global_data = save()
	save_file.store_var(global_data)
	
func load_game():
	if not FileAccess.file_exists("res://ShapesMetroidvania.save"):
		print("We didn't have to save or load this time.")
		load_game_check = false
		return # Error! We don't have a save to load.

	var save_file = FileAccess.open("res://ShapesMetroidvania.save", FileAccess.READ)
	var global_data = save_file.get_var()
	if global_data == null:
		print("global_data was null")
		return
	max_sides_player = global_data["max_sides_player"]
	sides_player = global_data["sides_player"]
	player_speed =global_data["player_speed"]
	player_acceleration =global_data["player_acceleration"]
	player_acceleration_slow =global_data["player_acceleration_slow"]
	player_max_speed =global_data["player_max_speed"]
	currency =global_data["currency"]
	game_paused =global_data["game_paused"]
	player_max_health =global_data["player_max_health"]
	room_activate =global_data["room_activate"]
	player_pos =global_data["player_pos"]
	playerjumponenter =global_data["playerjumponenter"]
	lobber_damage =global_data["lobber_damage"]
	max_health_sides_addition =global_data["max_health_sides_addition"]
	does_player_emit_light =global_data["does_player_emit_light"]
	can_I_open_a_menu =global_data["can_I_open_a_menu"]
	collectable_count =global_data["collectable_count"]
	scene =global_data["scene"]
	Collectable_array = global_data["Collectable_array"]
	load_game_check = true
