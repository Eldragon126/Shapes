extends Node2D

@export var Bullet: PackedScene = null

var target: Node2D = null

@onready var getSprite = $GunSprite
@onready var raycast = $RayCast2D
@onready var reloadTimer = $RayCast2D/ReloadTimer

func _ready():
	target = find_target()


func _physics_process(delta: float) -> void:
	if target != null:
		var angle_to_target: float = global_position.direction_to(target.global_position).angle()
		$GunSprite.rotation = angle_to_target
		raycast.global_rotation = angle_to_target
		
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			if collider and collider.is_in_group("Player"):
				reloadTimer.stop()
				if reloadTimer.is_stopped():
					shoot()
		
func shoot():
	#print("PEW")
	raycast.enabled = false
	reloadTimer.start()
	if Bullet:
		var bullet: Node2D = Bullet.instantiate()
		$".".add_child(bullet)
		#print($GunSprite/ShootTheBulletHere)
		bullet.global_position = $GunSprite/ShootTheBulletHere.global_position
		bullet.rotation = $GunSprite.global_rotation
		
	
	
func find_target():
	var new_target: Node2D = null
	
	if get_tree().has_group("Player"):
		new_target = get_tree().get_nodes_in_group("Player")[0]
	
	return new_target



func _on_reload_timer_timeout() -> void:
	raycast.enabled = true
