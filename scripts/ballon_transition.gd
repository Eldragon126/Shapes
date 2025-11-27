extends StaticBody2D
var player: Node2D
@export var current_floor: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = PlayerManager.player
	#position=player.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Area2D.get_overlapping_bodies().has(player):
		if player and Input.is_action_just_pressed("interact_button"):
			$TextureButton.show()
			PlayerManager.game_paused = true
			Engine.time_scale = 0
	else:
		$TextureButton.hide()
		



func _on_area_2d_body_entered(body: Node2D) -> void:
		pass
	


func _on_floor_3_pressed() -> void:
	print("thrid floor")
	#$AnimationPlayer.play("ballon_ui")
	if current_floor != 3:
		var ballon_down = get_tree().create_tween()
		var player_down = get_tree().create_tween()
		ballon_down.set_ignore_time_scale(true)
		player_down.set_ignore_time_scale(true)
		#player.get_node("./player_cam").enabled = false
		ballon_down.tween_property($Sprite2D, "scale", Vector2(2, 2), 2.0)
		ballon_down.parallel().tween_property(self, "position:y", self.position.y + 800, 6.0)
		player_down.parallel().tween_property(player, "position:y", player.position.y + 800, 6.0)
		ballon_down.parallel().tween_property($player_cam, "position:y", player.position.y + 800, 6.0)
	else:
		print("already on that floor")
