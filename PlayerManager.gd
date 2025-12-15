extends Node
var max_sides_player: int = 7
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
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	can_I_open_a_menu = true
	print("you can open a menu because the PlayerManager script was just loaded")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func save() -> void:
	pass
	var did_the_game_save_successfully: bool = true
