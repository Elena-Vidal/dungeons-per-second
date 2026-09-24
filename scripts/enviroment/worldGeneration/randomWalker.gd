extends Node2D

@export var _level_dimensions := Vector2i(4, 8)
@export var _start_room := Vector2i(-1, -1)
@export var _level_length : int = 7
var level_layout : Array

var _rng = RandomNumberGenerator.new()

func _ready() -> void:
	_initialize_level()
	_gen_start()
	_gen_path(_start_room, _level_length)
	_print_layout()


func _process(delta: float) -> void:
	pass

func _gen_path(current: Vector2i, length: int) -> bool:
	if length == 0:
		return true
	var current_room := current
	var move_direction : Vector2i
	match _rng.randi_range(0, 3):
		0:
			move_direction = Vector2i.UP
		1:
			move_direction = Vector2i.LEFT
		2:
			move_direction = Vector2i.DOWN
		3:
			move_direction = Vector2i.RIGHT
	for i in 4:
		if (current_room.x + move_direction.x >= 0 and current_room.x + move_direction.x < _level_dimensions.x
		and current_room.y + move_direction.y >= 0 and current_room.y + move_direction.y < _level_dimensions.y
		and not level_layout[current_room.x + move_direction.x][current_room.y + move_direction.y]):
			current_room += move_direction
			level_layout[current_room.x][current_room.y] = length
			if _gen_path(current_room, length - 1):
				return true
			else:
				level_layout[current_room.x][current_room.y] = 0
				current_room -= move_direction
		move_direction = Vector2i(move_direction.y, -move_direction.x)
	return false

func _print_layout() -> void:
	var layout : String = ""
	for y in range(_level_dimensions.y -1, -1, -1):
		for x in _level_dimensions.x:
			layout += "[" + str(level_layout[x][y]) + "]"
		layout += '\n'
	print_rich(layout)

func _gen_start() -> void:
	if _start_room.x < 0 or _start_room.x >= _level_dimensions.x:
		_start_room.x = _rng.randi_range(0, _level_dimensions.x - 1)
	if _start_room.y < 0 or _start_room.y >= _level_dimensions.y:
		_start_room.y = _rng.randi_range(0, _level_dimensions.y - 1)
	level_layout[_start_room.x][_start_room.y] = "[color=green]S[/color]"

func _initialize_level() -> void:
	for x in _level_dimensions.x:
		level_layout.append([])
		for y in _level_dimensions.y:
			level_layout[x].append(0)
