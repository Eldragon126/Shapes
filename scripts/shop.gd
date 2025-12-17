extends Control

func _ready() -> void:
	pass
	PlayerManager.can_I_open_a_menu = true
	var WhichSong = randi_range(1,2)
	if WhichSong == 1:
		$AudioStreamPlayer.play()
	else:
		$AudioStreamPlayer2.play()
	
func _process(delta: float) -> void:
	if PlayerManager.player_max_health >= 14:
		$CenterContainer/BuyThingsVBox/MaxHealth.hide()
	else:
		$CenterContainer/BuyThingsVBox/MaxHealth.show()
	#if Shooting variable > certain value: Show else hide.
	if PlayerManager.player_speed < 500:
		$CenterContainer/BuyThingsVBox/Movement.show()
	else:
		$CenterContainer/BuyThingsVBox/Movement.hide()
	
	if PlayerManager.lobber_damage <= 3:
		$CenterContainer/BuyThingsVBox/Damage.show()
	else:
		$CenterContainer/BuyThingsVBox/Damage.hide()
		
	if PlayerManager.max_health_sides_addition == false:
		$CenterContainer/BuyThingsVBox/MaxHealthisMaxHealthPlusSides.show()
	else:
		$CenterContainer/BuyThingsVBox/MaxHealthisMaxHealthPlusSides.hide()
		
	if PlayerManager.does_player_emit_light == false:
		$CenterContainer/BuyThingsVBox/Light.show()
	else:
		$CenterContainer/BuyThingsVBox/Light.hide()
	if PlayerManager.player_speed >= 500:
		$CenterContainer/BuyThingsVBox/Movement.hide()
	else:
		$CenterContainer/BuyThingsVBox/Movement.show()
	if PlayerManager.lobber_damage >= 3:
		$CenterContainer/BuyThingsVBox/Damage.hide()
	else:
		$CenterContainer/BuyThingsVBox/Damage.show()
	if PlayerManager.max_health_sides_addition == false:
		$CenterContainer/BuyThingsVBox/MaxHealthisMaxHealthPlusSides.show()
	else:
		$CenterContainer/BuyThingsVBox/MaxHealthisMaxHealthPlusSides.hide()
func _on_buy_pressed() -> void:
	$".".position = Vector2(0, -810)

func _on_quit_pressed() -> void:
	get_tree().paused = false
	PlayerManager.can_I_open_a_menu = true
	print("quitting the escape menu so the can I open a menu variable is now true.")
	$AudioStreamPlayer2.stop()
	$AudioStreamPlayer.stop()
	queue_free()   # closes the pause menu


func _on_max_health_pressed() -> void:
	if PlayerManager.player_max_health <= 10 && PlayerManager.currency >= 15:
		$CanBuy.play()
		PlayerManager.currency -= 15
		PlayerManager.player_max_health += 2
	else:
		$CannotBuy.play()


func _on_shooting_pressed() -> void:
	pass # Replace with function body.
	#Wait for Eric to make a reload timer for shooting, lower the timer's rate once this is pressed.

func _on_movement_pressed() -> void:
	if PlayerManager.currency >= 15 && PlayerManager.player_speed <= 500 && PlayerManager.player_max_speed <= 500:
		PlayerManager.currency -= 15
		PlayerManager.player_speed += 100
		PlayerManager.player_max_speed += 100
		$CanBuy.play()
	else:
		$CannotBuy.play()

func _on_damage_pressed() -> void:
	if PlayerManager.currency >= 15 and PlayerManager.lobber_damage < 3:
		PlayerManager.currency -= 15
		PlayerManager.lobber_damage += 1
		
	else:
		$CannotBuy.play()


func _on_max_healthis_max_health_plus_sides_pressed() -> void:
	if PlayerManager.currency >= 20 && PlayerManager.max_health_sides_addition == false:
		PlayerManager.max_health_sides_addition = true
		PlayerManager.currency -= 20
		$CanBuy.play()
	else:
		$CannotBuy.play()


func _on_light_pressed() -> void:
	if PlayerManager.currency >= 15 && PlayerManager.does_player_emit_light == false:
		PlayerManager.does_player_emit_light = true
		$CanBuy.play()
	else:
		$CannotBuy.play()
