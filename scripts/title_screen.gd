extends Control


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://nodes/debug_scene.tscn")
