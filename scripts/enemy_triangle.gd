extends CharacterBody2D
#var player = load("res://nodes/player.tscn")
#var player_triangle = player.instantiate()
var triangle_player: Node2D
var gravity = -1000
var speed = 1000
var enemy_jump_speed = -speed/2
var can_jump = true

signal enemy_hit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	triangle_player = PlayerManager.triangle_player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	#gravity
	velocity.y += -gravity*delta
	if is_on_floor():
		can_jump = true
	else:
		can_jump = false
	
	if triangle_player and global_position.distance_to(triangle_player.global_position) < 500 and (triangle_player.position.y + 300) > position.y:
		if triangle_player.position.x < position.x:
			velocity.x += -speed * delta
		if triangle_player.position.x > position.x:
			velocity.x += speed * delta
		
		if (triangle_player.position.y + 50) < position.y and can_jump:
			velocity.y = enemy_jump_speed
	else:
		velocity.x = 0
	
	move_and_slide()
	
		


func _on_collision_detection_body_entered(body: Node2D) -> void:
	emit_signal("enemy_hit")
	print("hit")
