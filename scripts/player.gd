class_name ShapePlayer
extends CharacterBody2D

var max_sides: int = PlayerManager.max_sides_player
var current_sides: int = PlayerManager.sides_player
var speed = PlayerManager.player_speed
var acceleration = PlayerManager.player_acceleration
var slow_acceleration = PlayerManager.player_acceleration_slow
var jump_speed = -speed*2
@export var gravity = speed * 5
@export var max_grav_speed = 100
@export var extra_jump = true
@export var jump_count: int = 0
@export var projectile_speed: float = 1000
var dash_speed = 1000
var can_dash = true
var max_speed = PlayerManager.player_max_speed
var alreadyaddedlight: bool = false
@onready var lobber_projectile = load("res://nodes/lobber_projectile.tscn")


# Variables For the Rope Player
var hang_point: Vector2
var hang_lenght: float
var is_hanging: bool
var tracking: PackedVector2Array
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var release_timer: Timer = $ReleaseTimer
@onready var rope_visual: RopeVisual = $RopeVisual
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var jump_buffer: Timer = $JumpBuffer
@export var max_speed_rope_player: float = 100
@export var accel: float = 1
@export var accel_curve: Curve
@export var friction: float = 4
@export_group("Rope", "rope_")
@export var rope_stiffnes: float = 1000
@export var rope_friction: float = 3
const SPEED = 1
const JUMP_VELOCITY = 1


#lobber is so cool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerManager.player = self
	if PlayerManager.room_activate:
		global_position = PlayerManager.player_pos
		if PlayerManager.playerjumponenter:
			velocity.y = jump_speed
		PlayerManager.room_activate = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	handle_input(delta)
	move_and_slide()
	update_movement(delta)
	if PlayerManager.sides_player == 5:
		if is_on_floor():
			coyote_timer.start()
		# rotate raycast to mouse
		ray_cast_2d.rotation = get_local_mouse_position().angle()
		# Add the gravity.
		#if velocity.y < 0 or is_hanging:
			#velocity += get_gravity() * delta
		#else:
			#velocity += get_gravity() * delta * 2
		
		#if (not jump_buffer.is_stopped()) and (not coyote_timer.is_stopped() or not release_timer.is_stopped()):
			#velocity.y = JUMP_VELOCITY
			#jump_buffer.stop()
			#coyote_timer.stop()
#		if Input.is_action_just_released("up") and velocity.y < 0:
#			velocity.y = 0
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("ui_left", "ui_right")
		var norm_speed = abs(velocity.x) / max_speed_rope_player
		if is_on_floor():
			# Accel when on floor
			velocity.x += accel * max_speed_rope_player * direction * delta * accel_curve.sample(norm_speed)
			velocity.x -= friction * max_speed_rope_player * delta * norm_speed * sign(velocity.x)
		else:
			pass
			# Accel less when on air
			velocity.x += accel * max_speed_rope_player * direction * delta * accel_curve.sample(norm_speed) * .5
		update_hanging(delta)
		update_tracking()
		queue_redraw()
		move_and_slide()

func update_hanging(delta):
	if not is_hanging: return
	var hang_local: Vector2 = to_local(hang_point)
	ray_cast_2d.rotation = hang_local.angle()
	var length_ratio = max(0, hang_local.length() - hang_lenght)
	# Stiffness force of rope
	velocity += length_ratio * rope_stiffnes * hang_local.normalized() * delta * .9
	# Damping of the rope
	velocity -= rope_friction * sign(velocity.dot(hang_local)) * hang_local.normalized() * delta * sign(length_ratio)

func update_tracking():
	tracking.reverse()
	tracking.append(global_position)
	tracking.reverse()
	if tracking.size() > 100:
		tracking.resize(100)

		
func _process(_delta: float) -> void: #Underscored it to stop errors, if you're ever coding in this just undo the underscore.
	#Changes Animation and collision based on value of current_side ammount, allows for a better level system
	PlayerManager.scene = get_tree().current_scene.scene_file_path
	print("The new scene is:" + str(PlayerManager.scene))
	if PlayerManager.max_health_sides_addition == false: $Health.set_max_health(PlayerManager.player_max_health)
	else: $Health.set_max_health(PlayerManager.player_max_health + PlayerManager.sides_player)
	$UI/TemporaryHealthBar.value = $Health.health
	if PlayerManager.max_health_sides_addition == false:
		$UI/TemporaryHealthBar.max_value = PlayerManager.player_max_health
	else:
		$UI/TemporaryHealthBar.max_value = PlayerManager.player_max_health + PlayerManager.sides_player
	if PlayerManager.max_sides_player > 7:
		PlayerManager.max_sides_player = 7
	if PlayerManager.max_sides_player < 3:
		PlayerManager.max_sides_player = 3
	if PlayerManager.sides_player != 7:
		$UI/Sides.text = "Your sides: " + str(PlayerManager.sides_player)
	else: $UI/Sides.text = "Your sides: are infinite!"
	if PlayerManager.does_player_emit_light == true && alreadyaddedlight == false:
		var light = preload("res://nodes/player_light.tscn")
		var lighted = light.instantiate()
		get_parent().add_child(lighted)
		lighted.position = $".".position
		print("Created a light for the player")
		alreadyaddedlight = true
	else:
		var is_there_light = get_tree().get_nodes_in_group("Light")
		if is_there_light != null:
			pass
		else:
			alreadyaddedlight = false
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
		spidey_webs()
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
		wall_climb()
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


func update_movement(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.x = clamp(velocity.x, -max_speed, max_speed)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and PlayerManager.sides_player == 5:
		# Debug jump to position
		if event.button_index == 2 and event.pressed:
			#global_position = get_global_mouse_position()
			pass
		if event.button_index == 1:
			# Release
			if is_hanging and not event.pressed:
				velocity *= 1.1
				release_timer.start()
				rope_visual.clear()
			var can_hang: bool = ray_cast_2d.is_colliding()
			is_hanging = event.pressed and can_hang
			# Hang
			if is_hanging:
				#extra_jump = true
				hang_point = ray_cast_2d.get_collision_point()
				hang_lenght = ray_cast_2d.global_position.distance_to(hang_point)
				hang_lenght = max(60, hang_lenght)
				rope_visual.create_rope(global_position, hang_point, hang_lenght)
			queue_redraw()

func _draw() -> void:
	# draw tracking
	#if tracking:
		#draw_polyline(global_transform.affine_inverse() * tracking, Color(0.352, 0.807, 0.867, 1.0), 2)
	# drawing hanging point
	if PlayerManager.sides_player == 5:
		if is_hanging:
			draw_circle(to_local(hang_point), 8, Color(1.0, 0.0, 0.0, 1.0))
		# drawing rope
		var line: PackedVector2Array
		if rope_visual.segments: for seg in rope_visual.segments:
			line.append(to_local(seg.global_position))
		line.append(to_local(hang_point))
		if is_hanging:
			line.append(to_local(hang_point))
		if line.size() >= 2:
			draw_polyline(line, Color(0.496, 0.496, 0.496, 1.0), 3)

func handle_input(delta: float) -> void:
	var direction = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	var dir = Vector2(direction, direction_y)
	if dir.length() > 0:
		dir = dir.normalized()
	if Input.is_action_just_pressed("jump") and (is_on_floor() || extra_jump):
		velocity.y = jump_speed
		$Jump.volume_db = -30.0
		$Jump.play()
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
				rotation += direction *0.2
			elif velocity.length() > 300:
				rotation += direction * 2
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
			velocity.x = 25 * (direction * dash_speed)
			velocity.x -= 25 * (direction * dash_speed * delta)
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
	get_tree().change_scene_to_file("res://nodes/level_rooms/title_screen.tscn")

func wall_climb() -> void:
	print("Wall climb is the best time")
	# This is the cool version
	#if is_on_wall():
	#	velocity.y = 100
	#	gravity = 0
	if is_on_wall():
		if Input.is_action_pressed("jump"):
			$Jump.play()
			velocity.y = -300
		else:
			velocity.y = 100
	
	

func spidey_webs() -> void:
	print("Spidey webssss")
	
		
