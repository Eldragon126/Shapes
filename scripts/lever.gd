extends Node2D
var player = Node2D
var off = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = PlayerManager.player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player and global_position.distance_to(player.global_position) < 200 and Input.is_action_just_pressed("interact_button") and off == false:
		$AnimationPlayer.play("LeverOff")
		await $AnimationPlayer.animation_finished
		off = true
	if player and global_position.distance_to(player.global_position) < 200 and Input.is_action_just_pressed("interact_button") and off:
		$AnimationPlayer.play("LeverPull")
		await $AnimationPlayer.animation_finished
		off = false
