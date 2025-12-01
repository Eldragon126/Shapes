extends Node2D
@export var player: Node2D
@export var max_speed = 3000
func _ready() -> void:
	player = PlayerManager.player

func _physics_process(delta: float) -> void:
	$".".linear_velocity = $".".linear_velocity.limit_length(max_speed)
	if abs(player.global_position - $".".global_position) < Vector2(100,50) && player.global_position != null:
		$".".linear_velocity = $".".linear_velocity/1.5#Vector2(0,0)
	$".".angular_velocity = $".".get_angle_to(player.global_position)
	#if abs(player.global_position - $".".global_position) < Vector2(30,10) && player.global_position != null:
		#$".".linear_velocity = $".".linear_velocity/2#Vector2(0,0)
		#print("The force of the player light should be less")
	if abs(player.global_position - $".".global_position) < Vector2(500,500) && player.global_position != null:
		#print("adding force to player light")
		if player.global_position.y < $".".global_position.y + 100:
			if player.global_position.x < $".".global_position.x:
				$".".apply_force(Vector2(-600, -600))
				
				#$".".linear_velocity = Vector2(-500, -100)
			else:
				$".".apply_force(Vector2(600, -600))
				#$".".linear_velocity = Vector2(500, -100)
		else:
			if player.global_position.x < $".".global_position.x:
				$".".apply_force(Vector2(-600, 600))
				#$".".linear_velocity = Vector2(-500, 100)
			else:
				$".".apply_force(Vector2(600, 600))
				#$".".linear_velocity = Vector2(500, 100)
	else:
		#print("adding linear velocity to player light")
		if player.global_position.y < $".".global_position.y + 100:
			if player.global_position.x < $".".global_position.x:
				#$".".apply_force(Vector2(-100, -10))
				$".".linear_velocity = Vector2(-3000, -1000)
			else:
				#$".".apply_force(Vector2(100, -10))
				$".".linear_velocity = Vector2(3000, -1000)
		else:
			if player.global_position.x < $".".global_position.x:
				#$".".apply_force(Vector2(-100, 10))
				$".".linear_velocity = Vector2(-3000, 1000)
				
			else:
				#$".".apply_force(Vector2(100, 10))
				$".".linear_velocity = Vector2(3000, 1000)
