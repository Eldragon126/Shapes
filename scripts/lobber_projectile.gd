extends RigidBody2D
var player = load("res://nodes/player_triangle.tscn")
var player_triangle = player.instantiate()
var projectile_speed = 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = player_triangle.position
	var x = Input.get_axis("ui_left", "ui_right")
	var y = Input.get_axis("ui_up", "ui_down")
	var direction: Vector2 = Vector2(x, y).normalized()
	print(direction)
	print("Direction:", direction, " Type:", typeof(direction))
	#linear_velocity = direction.normalized() * projectile_speed
	linear_velocity = Vector2(x,-1) * projectile_speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(player_triangle.position)
	pass
	
func _physics_process(delta: float) -> void:
	pass
	
