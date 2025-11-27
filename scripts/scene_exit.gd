extends Area2D

@export var connected_room: String
@export var player_pos: Vector2
@export var playerjumponenter: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body == PlayerManager.player:
		PlayerManager.room_activate = true
		PlayerManager.game_paused = false
		Engine.time_scale = 1
		PlayerManager.player_pos = player_pos
		PlayerManager.playerjumponenter = playerjumponenter
		get_tree().call_deferred("change_scene_to_file", connected_room)
