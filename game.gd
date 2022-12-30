extends Node


const WIDTH_IN_TILES := 20
const HEIGHT_IN_TILES := 20

enum TileMapLayers { SNAKE_AND_APPLE = 0 }
enum TileSetIds { NONE = -1, SNAKE = 0, APPLE = 1 }

var apple_position := _place_apple()
var snake_body := [Vector2i(5, 10), Vector2i(4, 10), Vector2i(3, 10)]
var snake_direction := Vector2i.RIGHT 
var add_apple := false

@onready var tile_map: TileMap = $TileMap


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_up") and snake_direction != Vector2i.DOWN:
		snake_direction = Vector2i.UP
	if Input.is_action_just_pressed("ui_down") and snake_direction != Vector2i.UP:
		snake_direction = Vector2i.DOWN
	if Input.is_action_just_pressed("ui_left") and snake_direction != Vector2i.RIGHT:
		snake_direction = Vector2i.LEFT
	if Input.is_action_just_pressed("ui_right") and snake_direction != Vector2i.LEFT:
		snake_direction = Vector2i.RIGHT


func _on_snake_tick_timer_timeout() -> void:
	_move_snake()
	_draw_snake()
	_check_apple_eaten()
	_draw_apple()
	_check_game_over()


func _place_apple() -> Vector2i:
	return Vector2i(
		randi_range(0, WIDTH_IN_TILES - 1),
		randi_range(0, HEIGHT_IN_TILES - 1),
	)


func _check_apple_eaten() -> void:
	if apple_position == snake_body[0]:
		add_apple = true
		apple_position = _place_apple()


func _check_game_over() -> void:
	var head := snake_body[0]
	if head.x > WIDTH_IN_TILES - 1 or head.x < 0 or head.y > HEIGHT_IN_TILES - 1 or head.y < 0:
		_reset()
		
	for body_part in snake_body.slice(1):
		if body_part == head:
			_reset()


func _reset() -> void:
	snake_body = [Vector2i(5, 10), Vector2i(4, 10), Vector2i(3, 10)]
	snake_direction = Vector2i.RIGHT


func _draw_apple() -> void:
	tile_map.set_cell(TileMapLayers.SNAKE_AND_APPLE, apple_position, TileSetIds.APPLE, Vector2i.ZERO)


func _draw_snake() -> void:
	for part_position in snake_body:
		tile_map.set_cell(TileMapLayers.SNAKE_AND_APPLE, part_position, TileSetIds.SNAKE, Vector2i(7, 0))


func _move_snake() -> void:
	tile_map.clear_layer(TileMapLayers.SNAKE_AND_APPLE)
	snake_body.push_front(snake_body[0] + snake_direction)
	if add_apple:
		add_apple = false
	else:
		snake_body.pop_back()
