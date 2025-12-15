extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		PlayerManager.max_sides_player += 1
		var coineffect_scene = load("res://nodes/collectable_effect.tscn")
		var coineffect_instance = coineffect_scene.instantiate()
		
		get_parent().add_child(coineffect_instance)
		queue_free()
		$AudioStreamPlayer.play()
	else:
		pass
