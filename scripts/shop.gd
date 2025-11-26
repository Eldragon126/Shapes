extends Control

func _ready() -> void:
	pass
	
func _on_buy_pressed() -> void:
	$".".position = Vector2(0, -648)

func _on_quit_pressed() -> void:
	get_tree().paused = false
	queue_free()   # closes the pause menu
