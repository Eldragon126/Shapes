extends Control

func _ready() -> void:
	$"Option Menu".hide()
	print("The Escape menu exists and is lively")
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape_interact"):
		queue_free()
	else:
		pass


func _on_options_pressed() -> void:
	$VFlowContainer.hide()
	$"Option Menu".show()

func _on_quit_pressed() -> void:
	PlayerManager.save()
	get_tree().paused = false
	get_tree().quit()


func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://nodes/level_rooms/title_screen.tscn")
