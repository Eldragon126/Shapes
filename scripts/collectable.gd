extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		queue_free()
		PlayerManager.collectable_count += 1
	else:
		pass
