extends Control

func _ready() -> void:
	pass
	var WhichSong = randi_range(1,2)
	if WhichSong == 1:
		$AudioStreamPlayer.play()
	else:
		$AudioStreamPlayer2.play()
	
func _on_buy_pressed() -> void:
	$".".position = Vector2(0, -648)

func _on_quit_pressed() -> void:
	get_tree().paused = false
	$AudioStreamPlayer2.stop()
	$AudioStreamPlayer.stop()
	queue_free()   # closes the pause menu


func _on_max_health_pressed() -> void:
	pass # Replace with function body.


func _on_shooting_pressed() -> void:
	pass # Replace with function body.


func _on_movement_pressed() -> void:
	pass # Replace with function body.


func _on_damage_pressed() -> void:
	pass # Replace with function body.


func _on_max_healthis_max_health_plus_sides_pressed() -> void:
	pass # Replace with function body.
