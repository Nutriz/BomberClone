extends Node

onready var block_scn = preload("res://scenes/Block.tscn")

const TILEMAP_WIDTH = 14
const TILEMAP_HEIGHT = 12
const FLOOR_BLOCK = 2

const PLAYER1_ZONE = [Vector2(1,1), Vector2(2,1), Vector2(1,2), Vector2(1,1)]
const PLAYER2_ZONE = [Vector2(13, 11), Vector2(13, 10), Vector2(12, 11)]

func _ready():
	spawn_bricks()

func spawn_bricks():
	for y in range(1, TILEMAP_HEIGHT):
		for x in range(1, TILEMAP_WIDTH):
			var cell_pos = Vector2(x, y) # pos in tilemap unit
			if not is_in_player_zones(cell_pos):
				var cell_id = $TileMap.get_cellv(cell_pos)
				if cell_id == FLOOR_BLOCK and rand_range(0, 2) < 1:
					var block = block_scn.instance()
					block.position = $TileMap.map_to_world(cell_pos) + Vector2(8,8) # +8 because block pos is centered
					$Blocks.add_child(block)

func is_in_player_zones(cell_pos):
	return PLAYER1_ZONE.find(cell_pos) != -1 || PLAYER2_ZONE.find(cell_pos) != -1