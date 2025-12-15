extends StaticBody2D
var player: Node2D
@export var current_floor: int
var floor_selected = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = PlayerManager.player
	#position=player.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Area2D.get_overlapping_bodies().has(player):
		if player and Input.is_action_just_pressed("interact_button"):
			$ElevatorButtons.show()
			PlayerManager.game_paused = true
			Engine.time_scale = 0
	else:
			$ElevatorButtons.hide()
	if PlayerManager.game_paused == true and Input.is_action_just_pressed("escape_interact") and $Area2D.get_overlapping_bodies().has(player):
		Engine.time_scale = 1
		PlayerManager.game_paused = false


func _on_floor_3_pressed() -> void:
	print("thrid floor")
	#$AnimationPlayer.play("ballon_ui")
	if current_floor != 3 and floor_selected == false:
		floor_selected = true
		$ElevatorButtons.hide()
		var ballon_down = get_tree().create_tween()
		var player_down = get_tree().create_tween()
		ballon_down.set_ignore_time_scale(true)
		player_down.set_ignore_time_scale(true)
		#player.get_node("./player_cam").enabled = false
		ballon_down.tween_property($ElevatorBalloon, "scale", Vector2(0.3, 0.3), 2.0)
		ballon_down.parallel().tween_property(self, "position:y", self.position.y + 800, 6.0)
		player_down.parallel().tween_property(player, "position:y", player.position.y + 800, 6.0)
		#ballon_down.parallel().tween_property($player_cam, "position:y", player.position.y + 800, 6.0)
	else:
		print("already on that floor")


func _on_floor_2_pressed() -> void:
	if current_floor == 1 and floor_selected == false:
		floor_selected = true
		var ballon_down = get_tree().create_tween()
		var player_down = get_tree().create_tween()
		ballon_down.set_ignore_time_scale(true)
		player_down.set_ignore_time_scale(true)
		#player.get_node("./player_cam").enabled = false
		ballon_down.tween_property($ElevatorBalloon, "scale", Vector2(0.3, 0.3), 2.0)
		ballon_down.parallel().tween_property(self, "position:y", self.position.y + 800, 6.0)
		player_down.parallel().tween_property(player, "position:y", player.position.y + 800, 6.0)
		#ballon_down.parallel().tween_property($player_cam, "position:y", player.position.y + 800, 6.0)
	elif current_floor == 3:
		floor_selected = true
		var ballon_up = get_tree().create_tween()
		var player_up = get_tree().create_tween()
		ballon_up.set_ignore_time_scale(true)
		player_up.set_ignore_time_scale(true)
		#player.get_node("./player_cam").enabled = false
		ballon_up.tween_property($ElevatorBalloon, "scale", Vector2(0.7, 0.7), 2.0)
		ballon_up.parallel().tween_property(self, "position:y", self.position.y - 800, 6.0)
		player_up.parallel().tween_property(player, "position:y", player.position.y - 800, 6.0)
		#ballon_up.parallel().tween_property($player_cam, "position:y", player.position.y - 800, 6.0)
	else:
		pass


func _on_floor_1_pressed() -> void:
	if current_floor != 1 and floor_selected == false:
		floor_selected = true
		var ballon_up = get_tree().create_tween()
		var player_up = get_tree().create_tween()
		ballon_up.set_ignore_time_scale(true)
		player_up.set_ignore_time_scale(true)
		#player.get_node("./player_cam").enabled = false
		ballon_up.tween_property($ElevatorBalloon, "scale", Vector2(.7, 0.7), 2.0)
		ballon_up.parallel().tween_property(self, "position:y", self.position.y - 800, 6.0)
		player_up.parallel().tween_property(player, "position:y", player.position.y - 800, 6.0)
		#ballon_up.parallel().tween_property($player_cam, "position:y", player.position.y - 800, 6.0)
