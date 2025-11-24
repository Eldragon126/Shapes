extends CharacterBody2D
var max_sides: int = PlayerManager.max_sides_player
var current_sides: int = PlayerManager.sides_player
@export var speed = 400
@export var acceleration = 80
@export var slow_acceleration = 80
@export var jump_speed = -speed*2
@export var gravity = speed * 5
@export var max_grav_speed = 100
@export var extra_jump = true
@export var jump_count = 0
@export var projectile_speed: float = 1000
@onready var lobber_projectile = preload("res://nodes/lobber_projectile.tscn")
#lobber is so cool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerManager.player = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void: #Underscored it to stop errors, if you're ever coding in this just undo the underscore.
	#Changes Animation and collision based on value of current_side ammount, allows for a better level system
	
	if PlayerManager.max_sides_player > 7:
		PlayerManager.max_sides_player = 7
	if PlayerManager.max_sides_player < 3:
		PlayerManager.max_sides_player = 3
	$UI/Sides.text = "Your sides: " + str(PlayerManager.sides_player)
	if PlayerManager.sides_player == 3 && PlayerManager.max_sides_player >= 3:
		$AnimatedSprite2D.animation = "Triangle"
		$TriangleMask.disabled = false
		$SquareMask.disabled = true
		$PentagonMask.disabled = true
		$HexagonMask.disabled = true
		$CircleMask.disabled = true
	elif PlayerManager.sides_player == 4 && PlayerManager.max_sides_player >= 4:
		$AnimatedSprite2D.animation = "Square"
		$SquareMask.disabled = false
		$PentagonMask.disabled = true
		$HexagonMask.disabled = true
		$CircleMask.disabled = true
		$TriangleMask.disabled = true
	elif PlayerManager.sides_player == 5 && PlayerManager.max_sides_player >= 5:
		$AnimatedSprite2D.animation = "Pentagon"
		$PentagonMask.disabled = false
		$HexagonMask.disabled = true
		$CircleMask.disabled = true
		$TriangleMask.disabled = true
		$SquareMask.disabled = true
	elif PlayerManager.sides_player == 6 && PlayerManager.max_sides_player >= 6:
		$AnimatedSprite2D.animation = "Hexagon"
		$HexagonMask.disabled = false
		$CircleMask.disabled = true
		$TriangleMask.disabled = true
		$SquareMask.disabled = true
		$PentagonMask.disabled = true
	elif PlayerManager.sides_player == 7 && PlayerManager.max_sides_player >= 7:
		$AnimatedSprite2D.animation = "Circle"
		$CircleMask.disabled = false
		$TriangleMask.disabled = true
		$SquareMask.disabled = true
		$PentagonMask.disabled = true
		$HexagonMask.disabled = true
	else:
		if PlayerManager.sides_player < 3:
			PlayerManager.sides_player = 3
		elif PlayerManager.sides_player > 7:
			PlayerManager.sides_player = 7
		print("Error, The side variable is either less than 3 or greater than 7")
		$TriangleMask.disabled = false
func _physics_process(delta: float) -> void:
	handle_input()
	move_and_slide()
	update_movement(delta)
	#handle_attack()

func update_movement(delta: float) -> void:
	velocity.y += gravity*delta

func handle_input() -> void:
	var direction = Input.get_axis("ui_left", "ui_right")
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
		if PlayerManager.sides_player == 3: extra_jump = true
		else: pass


#func handle_attack():
#	if Input.is_action_just_pressed("attack"):
#		var lobber_projectile_inst = lobber_projectile.instantiate()
#		add_child(lobber_projectile_inst)
