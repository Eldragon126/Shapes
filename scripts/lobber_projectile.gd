extends RigidBody2D
var player = load("res://nodes/player.tscn")
var player_triangle = player.instantiate()
var projectile_speed = 700
var player_ref: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var x = Input.get_axis("ui_left", "ui_right")
	var y = Input.get_axis("ui_up", "ui_down")
	var direction: Vector2 = Vector2(x, y).normalized()
	var pos = player_triangle.global_position
	position = pos
	#linear_velocity = direction.normalized() * projectile_speed
	if PlayerManager.sides_player == 3:
		linear_velocity = Vector2(x,-0.7) * projectile_speed
		if player_ref:
			position = player_ref.global_position
		else:
			push_error("didn't work")
	
	if PlayerManager.sides_player == 4:
		gravity_scale = 0
		linear_velocity = Vector2(x,y) * projectile_speed
		if player_ref:
			position = player_ref.global_position
		else:
			push_error("didn't work")
	
	if PlayerManager.sides_player == 5:
		gravity_scale = 0
		linear_velocity = Vector2(x,y) * projectile_speed
		if player_ref:
			position = player_ref.global_position
		else:
			push_error("didn't work")
	
	if PlayerManager.sides_player == 6:
		gravity_scale = 0
		linear_velocity = Vector2(x,y) * projectile_speed
		if player_ref:
			position = player_ref.global_position
		else:
			push_error("didn't work")
	
	if PlayerManager.sides_player == 7:
		gravity_scale = 0
		linear_velocity = Vector2(x,y) * projectile_speed
		if player_ref:
			position = player_ref.global_position
		else:
			push_error("didn't work")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	pass
	


func _on_kill_timer_timeout() -> void:
	queue_free()
