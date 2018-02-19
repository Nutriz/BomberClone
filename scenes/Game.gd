extends Node

onready var tilemap = $Stage/TileMap

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("drop_bomb"):
		$Blocks.get_child(0).destroy()