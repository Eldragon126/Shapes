extends Node2D
@onready var player_ref = PlayerManager.player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(player_ref)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("exist")
