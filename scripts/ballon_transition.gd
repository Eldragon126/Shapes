extends StaticBody2D
var player: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = PlayerManager.player
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Area2D.get_overlapping_bodies().has(player):
		if player and Input.is_action_just_pressed("interact_button"):
			$TextureButton.show()
			
			Engine.time_scale = 0
	else:
		$TextureButton.hide()



func _on_area_2d_body_entered(body: Node2D) -> void:
		pass
	
