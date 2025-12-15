extends RayCast2D
#COLLISION MASK TO RAYCAST IS 7, MEANING ANYTHIGN THAT YOU WANT IT TO ATTACH TO MUST HAVE A COLLISION MASK OF 7
func _draw() -> void:
	if not is_colliding(): return
	draw_circle(to_local(get_collision_point()), 8 * float(not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)), Color(0.824, 0.824, 0.824, 1.0))

func _process(delta: float) -> void:
	if is_colliding() and PlayerManager.sides_player == 5:
		queue_redraw()
	else:
		pass
