extends Area2D

@export var player: Node2D
func _ready() -> void:
	#player = PlayerManager.player
	#print("Player Manager.player is returning:" + str(PlayerManager.player))
	pass
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.disabled_everything = true
		body.extra_jump = false

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.disabled_everything = false
