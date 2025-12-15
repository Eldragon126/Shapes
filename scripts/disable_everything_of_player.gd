extends Area2D

@export var player: Node2D
func _ready() -> void:
	player = PlayerManager.player
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player.disabled_everything = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player.disabled_everything = false
