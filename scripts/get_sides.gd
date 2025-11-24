extends Area2D

var player = Node2D


func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		PlayerManager.max_sides_player += 1
		print("Sweet. Area entered. You should have more max sides!")
		$".".queue_free()
	else:
		print("didn't work.")
		print(body)
		print(player.max_sides)
