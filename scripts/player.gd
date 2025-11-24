extends CharacterBody2D
var max_sides: int = 7
var current_sides: int = 4
var speed = 400
var acceleration = 80
var slow_acceleration = 80
var jump_speed = -speed*2
var gravity = speed * 5
var max_grav_speed = 100
var extra_jump = true
var jump_count = 0
var projectile_speed: float = 1000
var dash_speed = 1000
var can_dash
@onready var lobber_projectile = preload("res://nodes/lobber_projectile.tscn")
#lobber is so cool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerManager.player = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void: #Underscored it to stop errors, if you're ever coding in this just undo the underscore.
	#Changes Animation and collision based on value of current_side ammount, allows for a better level system
	$UI/Sides.text = "Your sides: " + str(current_sides)
	if current_sides == 3 && max_sides >= 3:
		$AnimatedSprite2D.animation = "Triangle"
		$TriangleMask.disabled = false
		$SquareMask.disabled = true
		$PentagonMask.disabled = true
		$HexagonMask.disabled = true
		$CircleMask.disabled = true
	elif current_sides == 4 && max_sides >= 4:
		$AnimatedSprite2D.animation = "Square"
		$SquareMask.disabled = false
		$PentagonMask.disabled = true
		$HexagonMask.disabled = true
		$CircleMask.disabled = true
		$TriangleMask.disabled = true
	elif current_sides == 5 && max_sides >= 5:
		$AnimatedSprite2D.animation = "Pentagon"
		$PentagonMask.disabled = false
		$HexagonMask.disabled = true
		$CircleMask.disabled = true
		$TriangleMask.disabled = true
		$SquareMask.disabled = true
	elif current_sides == 6 && max_sides >= 6:
		$AnimatedSprite2D.animation = "Hexagon"
		$HexagonMask.disabled = false
		$CircleMask.disabled = true
		$TriangleMask.disabled = true
		$SquareMask.disabled = true
		$PentagonMask.disabled = true
	elif current_sides == 7 && max_sides >= 7:
		$AnimatedSprite2D.animation = "Circle"
		$CircleMask.disabled = false
		$TriangleMask.disabled = true
		$SquareMask.disabled = true
		$PentagonMask.disabled = true
		$HexagonMask.disabled = true
	else:
		$AnimatedSprite2D.animation = "Triangle"
		$TriangleMask.disabled = false
		current_sides = 3
func _physics_process(delta: float) -> void:
	handle_input()
	move_and_slide()
	update_movement(delta)
	#handle_attack()

func update_movement(delta: float) -> void:
	velocity.y += gravity*delta

func handle_input() -> void:
	var direction = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	var dir = Vector2(direction, direction_y)
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

	if direction == 0:
		velocity.x = move_toward(velocity.x,0,slow_acceleration)
	else:
		velocity.x = move_toward(velocity.x,speed* direction, acceleration)
	if is_on_floor():
		if current_sides == 3: extra_jump = true
	if current_sides == 4 and Input.is_action_just_pressed("ability_activate") and can_dash:
		if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
			velocity.x += direction * dash_speed
		if Input.is_action_pressed("ui_up"):
			velocity.y += direction_y * dash_speed
		if Input.is_action_pressed("ui_down"):
			velocity.y += direction_y * dash_speed
		can_dash = false
		$dash_downtime.start()


func _on_dash_downtime_timeout() -> void:
	if is_on_floor():
		can_dash = true
	else:
		$dash_downtime.start()
	
	
	
	
