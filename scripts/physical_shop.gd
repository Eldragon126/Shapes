extends Node2D
var player = Node2D
var alreadyinteracted: bool = false
func _ready() -> void:
	player = PlayerManager.player

func _process(delta: float) -> void:
	if player and global_position.distance_to(player.global_position) < 400 && PlayerManager.can_I_open_a_menu == true:
		if Input.is_action_just_pressed("interact_button") && alreadyinteracted == false:
			$".".PROCESS_MODE_WHEN_PAUSED
			get_tree().paused = true
			alreadyinteracted = true
			PlayerManager.can_I_open_a_menu = false
			print("You can't open a menu because of the escape menu being instantiated")
			var shop = load("res://nodes/shop.tscn").instantiate()
			$CanvasLayer.add_child(shop)
		if alreadyinteracted == false:
			$Label.show()
	else:
		$Label.hide()
		alreadyinteracted = false
		
	
