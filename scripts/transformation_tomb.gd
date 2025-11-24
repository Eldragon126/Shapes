extends Node2D


func _on_player_entered_transformer_body_entered(body: CharacterBody2D) -> void:
	$CircleShapes.visible = true
	$PlayerEnter.play("Stone")
	$PlayerExited.play("RESET")
	$PlayerExited.pause()



func _on_player_entered_transformer_body_exited(body: CharacterBody2D) -> void:
	
	$PlayerExited.play("Stone")
	$PlayerEnter.play("RESET")
	$PlayerEnter.pause()
	#$CircleShapes.visible = false
	
