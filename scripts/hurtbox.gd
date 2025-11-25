class_name HurtBox
extends Area2D

@export var sound: AudioStreamPlayer = null

signal recieved_damage(damage: int)

@export var health: Health
func _ready():
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox != null:
		health.health -= hitbox.damage
		recieved_damage.emit(hitbox.damage)
		if health.health == 0:
			health.health_depleted.emit()
			print("Emitted health depleated")
		else:
			pass
		recieved_damage.emit(hitbox.damage)
		



func _on_recieved_damage(damage: int) -> void:
	if sound != null:
		sound.play()
