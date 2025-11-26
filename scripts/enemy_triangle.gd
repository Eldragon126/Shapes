extends CharacterBody2D
#var player = load("res://nodes/player.tscn")
#var player_triangle = player.instantiate()
@export var player: Node2D
@export var gravity = -1000
@export var speed = 1000
var enemy_jump_speed = -speed/2
var can_jump = true
@export var distance_to_player = 500
signal enemy_hit
#Hello?
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = PlayerManager.player
	$ProgressBar.FILL_BEGIN_TO_END
	var rand_scale = randf_range(0.8,1.2)
	$".".apply_scale(Vector2(rand_scale, rand_scale))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ProgressBar.value = $Health.health
	

func _physics_process(delta: float) -> void:
	#gravity
	velocity.y += -gravity*delta
	if is_on_floor():
		can_jump = true
	else:
		can_jump = false
	
	if player and global_position.distance_to(player.global_position) < distance_to_player and (player.position.y + 300) > position.y:
		if player.position.x < position.x:
			velocity.x += -speed * delta
		if player.position.x > position.x:
			velocity.x += speed * delta
		
		if (player.position.y + 50) < position.y and can_jump:
			velocity.y = enemy_jump_speed
	else:
		velocity.x = 0
	if $Health.get_immortality() == true:
		$".".modulate = "ff97b4"
	else:
		$".".modulate = "ffffff"
	
	move_and_slide()
	
		


func _on_collision_detection_body_entered(body: Node2D) -> void:
	emit_signal("enemy_hit")
	print("hit")


func _on_health_health_depleted() -> void:
	queue_free()
	print("enemy triangle died!")
