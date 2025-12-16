extends Area2D
@export var WhichShape: int = 3

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		PlayerManager.max_sides_player += 1
		if WhichShape == 3:
			PlayerManager.sides_player = 3
		elif WhichShape == 4:
			PlayerManager.sides_player = 4
		elif WhichShape == 5:
			PlayerManager.sides_player = 5
		elif WhichShape == 6:
			PlayerManager.sides_player = 6
		elif WhichShape == 7:
			PlayerManager.sides_player = 7
		else:
			PlayerManager.sides_player = 3

func _ready() -> void:
	if WhichShape == 3:
		$AnimatedSprite2D.animation = "Triangle"
	elif WhichShape == 4:
		$AnimatedSprite2D.animation = "Square"
	elif WhichShape == 5:
		$AnimatedSprite2D.animation = "Pentagon"
	elif WhichShape == 6:
		$AnimatedSprite2D.animation = "Hexagon"
	elif WhichShape == 7:
		$AnimatedSprite2D.animation = "Circle"
	else:
		$AnimatedSprite2D.animation = "Triangle"
