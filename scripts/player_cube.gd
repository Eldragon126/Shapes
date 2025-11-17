extends CharacterBody2D
var speed = 400
var acceleration = 20
var slow_acceleration = 80
var jump_speed = -speed*2
var gravity = speed * 5
var max_grav_speed = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	handle_input()
	move_and_slide()
	update_movement(delta)
	
	

func update_movement(delta: float) -> void:
	velocity.y += gravity*delta

func handle_input() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
	
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == 0:
		velocity.x = move_toward(velocity.x,0,slow_acceleration)
	else:
		velocity.x = move_toward(velocity.x,speed* direction, acceleration)
