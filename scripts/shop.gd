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
