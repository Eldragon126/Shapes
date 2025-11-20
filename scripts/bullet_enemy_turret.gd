extends AnimatableBody2D

const RIGHT = Vector2.RIGHT
@export var SPEED: int = 200

func _physics_process(delta: float) -> void:
	var movement = RIGHT.rotated(rotation) * SPEED * delta
	global_position += movement
	
func destroy():
	queue_free()

func _on_area_2d_body_entered(body) -> void:
	if body.is_in_group("Player"):
		destroy()
		#Do some damage or something
