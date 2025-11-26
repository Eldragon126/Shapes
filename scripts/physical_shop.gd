extends Node2D
var player = Node2D

func _ready() -> void:
	player = PlayerManager.player

func _process(delta: float) -> void:
	if player and global_position.distance_to(player.global_position) < 400:
		if Input.is_action_just_pressed("interact_button"):
			$".".PROCESS_MODE_WHEN_PAUSED
			get_tree().paused = true
			var shop = load("res://nodes/shop.tscn").instantiate()
			$CanvasLayer.add_child(shop)
		$Label.show()
	else:
		$Label.hide()
	
