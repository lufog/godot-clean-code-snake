extends Node


const WIDTH_IN_TILES := 20
const HEIGHT_IN_TILES := 20

enum TileMapLayers { SNAKE = 0, APPLES = 1 }
enum TileSetIds { NONE = -1, SNAKE = 0, APPLE = 1 }

var apple_position := _place_apple()

@onready var tile_map: TileMap = $TileMap


func _ready() -> void:
	#var test := tile_map.get_cell_atlas_coords(TileMapLayers.SNAKE, Vector2i(0, 0))
	var test := tile_map.get_cell_source_id(TileMapLayers.SNAKE, Vector2i(0, 0))
	print(test)
	_draw_apple(_place_apple())


func _place_apple() -> Vector2i:
	return Vector2i(
		randi_range(0, WIDTH_IN_TILES - 1),
		randi_range(0, HEIGHT_IN_TILES - 1),
	)


func _draw_apple(tile_coords: Vector2i) -> void:
	tile_map.set_cell(
		TileMapLayers.APPLES, tile_coords,
		TileSetIds.APPLE, Vector2i.ZERO
	)
