class_name HurtBox
extends Area2D

@export var sound: AudioStreamPlayer = null
@export var immortality_time = 1
signal recieved_damage(damage: int)

@export var health: Health
func _ready():
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox != null:
		if health.immortality == false:
			health.health -= hitbox.damage
			recieved_damage.emit(hitbox.damage)
			health.set_temporary_immortality(immortality_time)
			recieved_damage.emit(hitbox.damage)
		if health.health == 0:
			health.health_depleted.emit()
			print("Emitted health depleated")
		else:
			pass
		
	else:
		print("This thing doesn't have a hitbox or is currently immortal.")
		print("The immortality for this object is, " + str(health.get_immortality()))



func _on_recieved_damage(damage: int) -> void:
	if sound != null:
		sound.play()
	else:
		return
