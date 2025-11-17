extends Node2D
@onready var lobber_projectile = preload("res://nodes/lobber_projectile.tscn")


func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		var lobber_projectile_inst = lobber_projectile.instantiate()
		add_child(lobber_projectile_inst)
