extends RigidBody2D
@export var player: Node2D

func _ready() -> void:
	var rand_scale = randf_range(0.3 + 0.06 ,0.5 + 0.07)
	$".".apply_scale(Vector2(rand_scale, rand_scale))
	player = PlayerManager.player

func _physics_process(delta: float) -> void:
	if player.global_position.y < $".".global_position.y:
		if player.global_position.x < $".".global_position.x:
			$".".apply_force(Vector2(-500, -100))
		else:
			$".".apply_force(Vector2(500, -100))
	else:
		if player.global_position.x < $".".global_position.x:
			$".".apply_force(Vector2(-500, 100))
		else:
			$".".apply_force(Vector2(500, 100))
		
