extends Node2D
var player: Node2D


func _on_player_entered_transformer_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$CircleShapes.visible = true
		$PlayerEnter.play("Stone")
		$PlayerExited.play("RESET")
		$PlayerExited.pause()
		$AnimationPlayer.play("Pulse")
		$AudioStreamPlayer2D.play()
		if PlayerManager.max_sides_player == 3:
			$CircleShapes/Triangle.visible = true
			$CircleShapes/Square.visible = false
			$CircleShapes/Pentagon.visible = false
			$CircleShapes/Hexagon.visible = false
			$CircleShapes/Circle.visible = false
			$CircleShapes/Triangle.disabled = false
			$CircleShapes/Square.disabled = true
			$CircleShapes/Pentagon.disabled = true
			$CircleShapes/Hexagon.disabled = true
			$CircleShapes/Circle.disabled = true
		elif PlayerManager.max_sides_player == 4:
			$CircleShapes/Triangle.visible = true
			$CircleShapes/Square.visible = true
			$CircleShapes/Pentagon.visible = false
			$CircleShapes/Hexagon.visible = false
			$CircleShapes/Circle.visible = false
			$CircleShapes/Triangle.disabled = false
			$CircleShapes/Square.disabled = false
			$CircleShapes/Pentagon.disabled = true
			$CircleShapes/Hexagon.disabled = true
			$CircleShapes/Circle.disabled = true
		elif PlayerManager.max_sides_player == 5:
			$CircleShapes/Triangle.visible = true
			$CircleShapes/Square.visible = true
			$CircleShapes/Pentagon.visible = true
			$CircleShapes/Hexagon.visible = false
			$CircleShapes/Circle.visible = false
			$CircleShapes/Triangle.disabled = false
			$CircleShapes/Square.disabled = false
			$CircleShapes/Pentagon.disabled = false
			$CircleShapes/Hexagon.disabled = true
			$CircleShapes/Circle.disabled = true
		elif PlayerManager.max_sides_player == 6:
			$CircleShapes/Triangle.visible = true
			$CircleShapes/Square.visible = true
			$CircleShapes/Pentagon.visible = true
			$CircleShapes/Hexagon.visible = true
			$CircleShapes/Circle.visible = false
			$CircleShapes/Triangle.disabled = false
			$CircleShapes/Square.disabled = false
			$CircleShapes/Pentagon.disabled = false
			$CircleShapes/Hexagon.disabled = false
			$CircleShapes/Circle.disabled = true
		elif PlayerManager.max_sides_player == 7:
			$CircleShapes/Triangle.visible = true
			$CircleShapes/Square.visible = true
			$CircleShapes/Pentagon.visible = true
			$CircleShapes/Hexagon.visible = true
			$CircleShapes/Circle.visible = true
			$CircleShapes/Triangle.disabled = false
			$CircleShapes/Square.disabled = false
			$CircleShapes/Pentagon.disabled = false
			$CircleShapes/Hexagon.disabled = false
			$CircleShapes/Circle.disabled = false
		else:
			print("Error. Player has false amount of sides.")
			$CircleShapes/Triangle.visible = true
			$CircleShapes/Square.visible = true
			$CircleShapes/Pentagon.visible = true
			$CircleShapes/Hexagon.visible = true
			$CircleShapes/Circle.visible = true
	else:
		pass
	


func _on_player_entered_transformer_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$PlayerExited.play("Stone")
		$PlayerEnter.play("RESET")
		$PlayerEnter.pause()
		$AnimationPlayer.play("RESET")
		$AnimationPlayer.pause()
		$AudioStreamPlayer2D.stop()
	else:
		pass
	
	#$CircleShapes.visible = false
	
	


func _on_triangle_pressed() -> void:
	if PlayerManager.max_sides_player >= 3:
		PlayerManager.sides_player = 3
		print("Player sides just changed to 3 via button pressed")
		$Transformed.play()


func _on_square_pressed() -> void:
	if PlayerManager.max_sides_player >= 4:
		PlayerManager.sides_player = 4
		print("Player sides just changed to 4 via button pressed")
		$Transformed.play()
		#Made it a global variable, little messy
func _on_pentagon_pressed() -> void:
	if PlayerManager.max_sides_player >= 5:
		PlayerManager.sides_player = 5
		print("Player sides just changed to 5 via button pressed")
		$Transformed.play()

func _on_hexagon_pressed() -> void:
	if PlayerManager.max_sides_player >= 6:
		PlayerManager.sides_player = 6
		print("Player sides just changed to 6 via button pressed")
		$Transformed.play()


func _on_circle_pressed() -> void:
	if PlayerManager.max_sides_player >= 7:
		PlayerManager.sides_player = 7
		print("Player sides just changed to 7 via button pressed")
		$Transformed.play()
