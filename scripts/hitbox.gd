class_name HitBox
extends Area2D

#This allows for HITTING. It affects hurtboxes, changing health.
@export var damage: int = 1 : set = set_damage, get = get_damage

func set_damage(value: int):
	damage = value

func get_damage() -> int:
	return damage
