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
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
