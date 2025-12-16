extends Control
const  BPMRate: float = 60/130
func _ready() -> void:
	$"Option Menu".hide()
	print("The Escape menu exists and is lively")
	$VFlowContainer.show()
	$"Option Menu".hide()
func _process(delta: float) -> void:
	$Hello2.text = "You have " + str(PlayerManager.collectable_count) + " out of 14 collectables."
	if Input.is_action_just_pressed("escape_interact"):
		queue_free()
	else:
		pass
	$"Option Menu/FramesPerSecond".value = Engine.max_fps
	$"Option Menu/VolumePercent".value = db_to_linear(AudioServer.get_bus_volume_db(0))*100
func _on_options_pressed() -> void:
	$VFlowContainer.hide()
	$"Option Menu".show()
	$ButtonPressSound.play()
	PlayerManager.save_game()

func _on_quit_pressed() -> void:
	PlayerManager.can_I_open_a_menu = true
	PlayerManager.save_game()
	$ButtonPressSound.play()
	print("Leaving escape menu to leave game, can I open a menu is true")
	get_tree().paused = false
	get_tree().quit()


func _on_menu_pressed() -> void:
	PlayerManager.can_I_open_a_menu = true
	print("Leaving escape menu to go to start menu, can I open a menu is true")
	$ButtonPressSound.play()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://nodes/level_rooms/title_screen.tscn")


func _on_cool_button_pressed() -> void:
	PlayerManager.save_game()
	$ButtonPressSound.play()
	


func _on_add_volume_pressed() -> void:
	if AudioServer.get_bus_volume_db(0) < 0: AudioServer.set_bus_volume_db(0, AudioServer.get_bus_volume_db(0) + 1)
	else: pass
	$ButtonPressSound.play()

func _on_subtract_volume_pressed() -> void:
	AudioServer.set_bus_volume_db(0, AudioServer.get_bus_volume_db(0) - 1)
	$ButtonPressSound.play()
func _on_back_pressed() -> void:
	$VFlowContainer.show()
	$"Option Menu".hide()
	$ButtonPressSound.play()

func _on_add_fps_pressed() -> void:
	if Engine.max_fps < 120: Engine.max_fps = Engine.max_fps + 12
	$ButtonPressSound.play()

func _on_subtract_fps_pressed() -> void:
	if Engine.max_fps > 12: Engine.max_fps = Engine.max_fps - 12
	$ButtonPressSound.play()
