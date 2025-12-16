extends Area2D
@export var collectable_number: int

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		PlayerManager.collectable_count += 1
		var coineffect_scene = load("res://nodes/collectable_effect.tscn")
		var coineffect_instance = coineffect_scene.instantiate()
		PlayerManager.Collectable_array[collectable_number] = true
		get_parent().add_child(coineffect_instance)
		queue_free()
		$AudioStreamPlayer.play()
	else:
		pass
func _process(delta: float) -> void:
	if PlayerManager.Collectable_array[collectable_number] == true:
		hide()
	else:
		show()
