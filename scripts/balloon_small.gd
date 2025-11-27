extends Node2D
var player: Node2D = null
var balloon_on: bool = false
func _ready() -> void:
	player = PlayerManager.player

func _process(delta: float) -> void:
	if player and global_position.distance_to(player.global_position) < 200:
		if Input.is_action_just_pressed("interact_button"):
			if balloon_on == false:
				balloon_on = true
			else:
				balloon_on = false
				$Platform.gravity_scale = 0.1
		$Label.show()
	else:
		$Label.hide()
			
	if balloon_on == true:
		$Balloon.gravity_scale = -0.1
		$Platform.gravity_scale = 0.1
	else:
		$Balloon.gravity_scale = 0.0
		$Platform.gravity_scale = 0.1
