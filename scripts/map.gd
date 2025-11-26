extends Node2D
const lobber_projectile = preload("res://nodes/lobber_projectile.tscn")
@onready var player_ref = $player


func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		var lobber_projectile_inst = lobber_projectile.instantiate()
		lobber_projectile_inst.player_ref = player_ref
		add_child(lobber_projectile_inst)
