extends CharacterBody2D
var speed = 400
var acceleration = 80
var slow_acceleration = 80
var jump_speed = -speed*2
var gravity = speed * 5
var max_grav_speed = 100
var extra_jump = true
var jump_count = 0
var projectile_speed: float = 1000
var health = 100
@onready var lobber_projectile = preload("res://nodes/lobber_projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerManager.triangle_player = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	update_movement(delta)
	handle_input()
	move_and_slide()
	take_damage_death()
	#handle_attack()

func update_movement(delta: float) -> void:
	velocity.y += gravity*delta

func handle_input() -> void:
	if Input.is_action_just_pressed("jump") and (is_on_floor() || extra_jump):
		velocity.y = jump_speed
		jump_count += 1
		if jump_count > 1:
			extra_jump = false
			jump_count = 0
	
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == 0:
		velocity.x = move_toward(velocity.x,0,slow_acceleration)
	else:
		velocity.x = move_toward(velocity.x,speed* direction, acceleration)
	if !is_on_floor():
		rotation += (0.083 * direction)
	else:
		rotation = 0
		extra_jump = true

func take_damage_death():
	if health <= 0:
		queue_free()

#func handle_attack():
#	if Input.is_action_just_pressed("attack"):
#		var lobber_projectile_inst = lobber_projectile.instantiate()
#		add_child(lobber_projectile_inst)
