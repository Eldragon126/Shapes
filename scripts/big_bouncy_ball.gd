extends RigidBody2D
@export var player: Node2D
var rand = randf_range(0.2,1)
func _ready() -> void:
	scale = Vector2(rand,rand)
	player = PlayerManager.player
func _process(delta: float) -> void:
	if player.global_position < Vector2(4000 * rand,40000 * rand):
		freeze = false
