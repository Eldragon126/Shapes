extends Node2D
var player = Node2D
var off = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = PlayerManager.player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player and global_position.distance_to(player.global_position) < 200:
		$CenterContainer/Label.show()
	else:
		$CenterContainer/Label.hide()
	
	if player and global_position.distance_to(player.global_position) < 200 and Input.is_action_just_pressed("interact_button") and off == false:
		$AnimationPlayer.play("LeverOff")
		await $AnimationPlayer.animation_finished
		off = true
	if player and global_position.distance_to(player.global_position) < 200 and Input.is_action_just_pressed("interact_button") and off:
		$AnimationPlayer.play("LeverPull")
		await $AnimationPlayer.animation_finished
		off = false
	if off == true:
		$CenterContainer/Label.text ="E to Activate"
	else:
		$CenterContainer/Label.text ="Activated"



func _on_area_2d_body_entered(body: Node2D) -> void:
	print("touched Lever")
	if off == false:
		$AnimationPlayer.play("LeverOff")
		await $AnimationPlayer.animation_finished
		off = true
	else:
		$AnimationPlayer.play("LeverPull")
		await $AnimationPlayer.animation_finished
		off = false
