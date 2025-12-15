extends Node
var max_sides_player: int = 7
var sides_player: int = 0
var player_speed: int = 400
var player_acceleration: int = 1000
var player_acceleration_slow: int = 80
var player_max_speed: int = 1000
var player: Node2D = null
var currency: int = 1000
var game_paused = false
var player_max_health: int = 10
var room_activate = false
var player_pos: Vector2
var playerjumponenter: bool
var lobber_damage: int = 1
var max_health_sides_addition: bool = false
var does_player_emit_light: bool = false
var can_I_open_a_menu: bool = true
var collectable_count: int = 0
var starting_area = PROPERTY_USAGE_NODE_PATH_FROM_SCENE_ROOT
var scene
var load_game_check: bool = false
func _ready() -> void:
	can_I_open_a_menu = true
	print("you can open a menu because the PlayerManager script was just loaded")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"max_sides_player" : max_sides_player,
		"sides_player" : sides_player,
		"player_speed" : player_speed,
		"player_acceleration" : player_acceleration,
		"player_acceleration_slow" : player_acceleration_slow,
		"player_max_speed" : player_max_speed,
		"player" : player,
		"currency" : currency,
		"game_paused" : game_paused,
		"player_max_health" : player_max_health,
		"room_activate" : room_activate ,
		"player_pos" : player_pos,
		"playerjumponenter" : playerjumponenter,
		"lobber_damage" : lobber_damage,
		"max_health_sides_addition" : max_health_sides_addition,
		"does_player_emit_light" : does_player_emit_light,
		"can_I_open_a_menu" : can_I_open_a_menu,
		"collectable_count" : collectable_count,
		"scene" : scene
	}
	return save_dict
	
# Note: This can be called from anywhere inside the tree. This function is
# path independent.
# Go through everything in the persist category and ask them to return a
# dict of relevant variables.
func save_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.call("save")

		# JSON provides a static method to serialized JSON string.
		var json_string = JSON.stringify(node_data)

		# Store the save dictionary as a new line in the save file.
		save_file.store_line(json_string)

# Note: This can be called from anywhere inside the tree. This function
# is path independent.
func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		print("We didn't have to save or load this time.")
		load_game_check = false
		return # Error! We don't have a save to load.
		

	# We need to revert the game state so we're not cloning objects
	# during loading. This will vary wildly depending on the needs of a
	# project, so take care with this step.
	# For our example, we will accomplish this by deleting saveable objects.
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		i.queue_free()

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()

		# Creates the helper class to interact with JSON.
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure.
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object.
		var node_data = json.data

		# Firstly, we need to create the object and add it to the tree and set its position.
		var new_object = load(node_data["filename"]).instantiate()
		get_node(node_data["parent"]).add_child(new_object)
		new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])

		# Now we set the remaining variables.
		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			new_object.set(i, node_data[i])
		load_game_check = true
