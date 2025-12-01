extends Line2D
@onready var i: int = 0
func _physics_process(delta: float) -> void:
	handle_input()
func handle_input() -> void:
	if Input.is_action_just_pressed("attack"):
		$".".add_point(get_global_mouse_position())
		#$StaticBody2D/CollisionPolygon2D.polygon.resize(i)
		$StaticBody2D/CollisionPolygon2D.polygon.append(get_global_mouse_position())
		print("Added point on polygon")
		#if i >= 1: $StaticBody2D/CollisionPolygon2D
		i += 1
