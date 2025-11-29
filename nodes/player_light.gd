extends Node2D
@export var player: Node2D

func _ready() -> void:
	player = PlayerManager.player

func _physics_process(delta: float) -> void:
	if abs(player.global_position - $".".global_position) < Vector2(10,300) && player.global_position != null:
		$".".linear_velocity = $".".linear_velocity/60#Vector2(0,0)
		print("The force of the player light should be less")
	elif abs(player.global_position - $".".global_position) < Vector2(1000,1000) && player.global_position != null:
		print("adding force to player light")
		if player.global_position.y < $".".global_position.y + 200:
			if player.global_position.x < $".".global_position.x:
				$".".apply_force(Vector2(-300, -300))
				
				#$".".linear_velocity = Vector2(-500, -100)
			else:
				$".".apply_force(Vector2(300, -300))
				#$".".linear_velocity = Vector2(500, -100)
		else:
			if player.global_position.x < $".".global_position.x:
				$".".apply_force(Vector2(-300, 300))
				#$".".linear_velocity = Vector2(-500, 100)
			else:
				$".".apply_force(Vector2(300, 300))
				#$".".linear_velocity = Vector2(500, 100)
	else:
		print("adding linear velocity to player light")
		if player.global_position.y < $".".global_position.y + 200:
			if player.global_position.x < $".".global_position.x:
				#$".".apply_force(Vector2(-100, -10))
				$".".linear_velocity = Vector2(-1000, -1000)
			else:
				#$".".apply_force(Vector2(100, -10))
				$".".linear_velocity = Vector2(1000, -1000)
		else:
			if player.global_position.x < $".".global_position.x:
				#$".".apply_force(Vector2(-100, 10))
				$".".linear_velocity = Vector2(-1000, 1000)
				
			else:
				#$".".apply_force(Vector2(100, 10))
				$".".linear_velocity = Vector2(1000, 1000)
	
