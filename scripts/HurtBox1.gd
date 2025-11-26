class_name HurtBox1
extends Area2D


signal recieved_damage(damage: int)

@export var health: Health
func _ready():
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox != null:
		health.health -= hitbox.damage
		health.health_changed.emit()
		if health.health == 0:
			health.health_depleted.emit()
			print("Emitted health depleated")
		else:
			print("enemy hasn't died yet")
		recieved_damage.emit(hitbox.damage)
		
