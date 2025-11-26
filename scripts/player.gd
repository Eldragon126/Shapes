extends CharacterBody2D
var max_sides: int = PlayerManager.max_sides_player
var current_sides: int = PlayerManager.sides_player
@export var speed = 400
@export var acceleration = 1000
@export var slow_acceleration = 80
@export var jump_speed = -speed*2
@export var gravity = speed * 5
@export var max_grav_speed = 100
@export var extra_jump = true
@export var jump_count = 0
@export var projectile_speed: float = 1000
var dash_speed = 1000
var can_dash = true
var max_speed = 1000
@onready var lobber_projectile = preload("res://nodes/lobber_projectile.tscn")
#lobber is so cool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerManager.player = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void: #Underscored it to stop errors, if you're ever coding in this just undo the underscore.
	#Changes Animation and collision based on value of current_side ammount, allows for a better level system
	$TemporaryHealthBar.value = $Health.health
	if PlayerManager.max_sides_player > 7:
		PlayerManager.max_sides_player = 7
	if PlayerManager.max_sides_player < 3:
		PlayerManager.max_sides_player = 3
	if PlayerManager.sides_player != 7:
		$UI/Sides.text = "Your sides: " + str(PlayerManager.sides_player)
	else: $UI/Sides.text = "Your sides: are infinite!"
		
	if PlayerManager.sides_player == 3 && PlayerManager.max_sides_player >= 3:
		$AnimatedSprite2D.animation = "Triangle"
		$TriangleMask.disabled = false
		$SquareMask.disabled = true
		$PentagonMask.disabled = true
		$HexagonMask.disabled = true
		$CircleMask.disabled = true
		$HurtBox/TriangleMask.disabled = false
		$HurtBox/PentagonMask.disabled = true
		$HurtBox/HexagonMask.disabled = true
		$HurtBox/SquareMask.disabled = true
		$HurtBox/CircleMask.disabled =true
	elif PlayerManager.sides_player == 4 && PlayerManager.max_sides_player >= 4:
		$AnimatedSprite2D.animation = "Square"
		$SquareMask.disabled = false
		$PentagonMask.disabled = true
		$HexagonMask.disabled = true
		$CircleMask.disabled = true
		$TriangleMask.disabled = true
		$HurtBox/TriangleMask.disabled = true
		$HurtBox/PentagonMask.disabled = true
		$HurtBox/HexagonMask.disabled = true
		$HurtBox/SquareMask.disabled = false
		$HurtBox/CircleMask.disabled = true
	elif PlayerManager.sides_player == 5 && PlayerManager.max_sides_player >= 5:
		$AnimatedSprite2D.animation = "Pentagon"
		$PentagonMask.disabled = false
		$HexagonMask.disabled = true
		$CircleMask.disabled = true
		$TriangleMask.disabled = true
		$SquareMask.disabled = true
		$HurtBox/TriangleMask.disabled = true
		$HurtBox/PentagonMask.disabled = false
		$HurtBox/HexagonMask.disabled = true
		$HurtBox/SquareMask.disabled =true
		$HurtBox/CircleMask.disabled =true
	elif PlayerManager.sides_player == 6 && PlayerManager.max_sides_player >= 6:
		$AnimatedSprite2D.animation = "Hexagon"
		$HexagonMask.disabled = false
		$CircleMask.disabled = true
		$TriangleMask.disabled = true
		$SquareMask.disabled = true
		$PentagonMask.disabled = true
		$HurtBox/TriangleMask.disabled =true
		$HurtBox/PentagonMask.disabled =true
		$HurtBox/HexagonMask.disabled = false
		$HurtBox/SquareMask.disabled =true
		$HurtBox/CircleMask.disabled =true
	elif PlayerManager.sides_player == 7 && PlayerManager.max_sides_player >= 7:
		$AnimatedSprite2D.animation = "Circle"
		$CircleMask.disabled = false
		$TriangleMask.disabled = true
		$SquareMask.disabled = true
		$PentagonMask.disabled = true
		$HexagonMask.disabled = true
		$HurtBox/TriangleMask.disabled =true
		$HurtBox/PentagonMask.disabled =true
		$HurtBox/HexagonMask.disabled =true
		$HurtBox/SquareMask.disabled =true
		$HurtBox/CircleMask.disabled = false
	else:
		if PlayerManager.sides_player < 3:
			PlayerManager.sides_player = 3
		elif PlayerManager.sides_player > 7:
			PlayerManager.sides_player = 7
		print("Error, The side variable is either less than 3 or greater than 7")
		$TriangleMask.disabled = false
func _physics_process(delta: float) -> void:
	handle_input(delta)
	move_and_slide()
	update_movement(delta)
	

func update_movement(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.x = clamp(velocity.x, -max_speed, max_speed)


func handle_input(delta: float) -> void:
	var direction = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	var dir = Vector2(direction, direction_y)
	if dir.length() > 0:
		dir = dir.normalized()
	if Input.is_action_just_pressed("jump") and (is_on_floor() || extra_jump):
		velocity.y = jump_speed
		var tween = get_tree().create_tween()
		tween.tween_property($".", "rotation_degrees", 360 * direction, 0.6).set_trans(Tween.TRANS_LINEAR)
		print("I'm jumping??")
		jump_count += 1
		if jump_count > 1:
			extra_jump = false
			jump_count = 0
	if current_sides == 7:
		max_speed = 10000
	else:
		max_speed = 400
	if direction == 0:
		velocity.x = move_toward(velocity.x,0,slow_acceleration)
	else:
		if PlayerManager.sides_player != 7:
			velocity.x = move_toward(velocity.x,speed * direction, acceleration)
			print("it should be another shape other than circle")
			print("velocity is " + str(velocity.x))
			print("velocity is moving toward " + str(speed * direction + 1000))
		else:
			velocity.x = move_toward(velocity.x, speed * direction * 10, acceleration)
			if velocity.length() > 100:
				rotation += direction *0.03
			elif velocity.length() > 300:
				rotation += direction * 0.1
			print("velocity is " + str(velocity.x))
			print("velocity is moving toward " + str(speed * direction * 10))
			print("It should be a circle")
	if is_on_floor():
		if PlayerManager.sides_player == 3: extra_jump = true
		else: pass


#func handle_attack():
#	if Input.is_action_just_pressed("attack"):
#		var lobber_projectile_inst = lobber_projectile.instantiate()
#		add_child(lobber_projectile_inst)
	if PlayerManager.sides_player == 4 and Input.is_action_just_pressed("ability_activate") and can_dash:
		velocity.x = 0
		velocity.y = 0
		if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
			velocity.x = 10 * (direction * dash_speed)
			velocity.x -= 10 * (direction * dash_speed * delta)
		if Input.is_action_pressed("ui_up"):
			velocity.y = direction_y * dash_speed
			velocity.y -= direction_y * dash_speed * delta
		if Input.is_action_pressed("ui_down"):
			velocity.y = direction_y * dash_speed
			velocity.y -= direction_y * dash_speed * delta
		can_dash = false
		$dash_downtime.start()



func _on_dash_downtime_timeout() -> void:
	if is_on_floor():
		can_dash = true
	else:
		$dash_downtime.start()
	


func _on_health_health_depleted() -> void:
	$".".modulate = "fb003c"
	call_deferred("_go_to_title")
	print("The timer timed-out and is now changing the scene to the title screen.")

func _go_to_title() -> void:
	get_tree().change_scene_to_file("res://nodes/title_screen.tscn")
