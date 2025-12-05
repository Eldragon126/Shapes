extends CanvasLayer
var already_interacted_with_menu: bool = false

func _process(delta: float) -> void:
	$FPSDEBUG.text = "Current FPS: " + str(Engine.get_frames_per_second())
	if Input.is_action_just_pressed("escape_interact") && already_interacted_with_menu == false && PlayerManager.can_I_open_a_menu == true:
		print("player has pressed escape and is attempting to go to menu")
		already_interacted_with_menu = true
		PlayerManager.can_I_open_a_menu = false
		get_tree().paused = true
		var escape_menu = load("res://nodes/escape_menu.tscn").instantiate()
		$".".add_child(escape_menu)
		print("player should have created the escape menu scene.")
	elif Input.is_action_just_pressed("escape_interact") && already_interacted_with_menu == true && PlayerManager.can_I_open_a_menu == false:
		print("player has pressed escape and is attempting to leave menu")
		already_interacted_with_menu = false
		PlayerManager.can_I_open_a_menu = true
		get_tree().paused = false
		if $"."/EscapeMenu != null: $"."/EscapeMenu.queue_free()
		print("The escape menu is no longer lively")
	else:
		pass
