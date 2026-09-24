extends Node2D

@export var _level_dimensions := Vector2i(8, 8)
@export var _start_room := Vector2i(-1, -1)
@export var _level_length : int = 10
@export var _item_rooms : int = 3
@export var _item_path_lenght := Vector2i(1, 4)

var level_layout : Array
var possible_branches : Array[Vector2i]

var _rng = RandomNumberGenerator.new()

func _ready() -> void:
	_initialize_level()
	_gen_start()
	_gen_path(_start_room, _level_length, "R")
	_gen_item_rooms()
	_print_layout()


func _process(delta: float) -> void:
	pass

func _gen_item_rooms() -> void:
	var created_branches : int = 0
	var candidate : Vector2i
	while created_branches < _item_rooms and possible_branches.size():
		candidate = possible_branches[_rng.randi_range(0, possible_branches.size() - 1)]
		if _gen_path(candidate, _rng.randi_range(_item_path_lenght.x, _item_path_lenght.y), str(created_branches + 1)):
			created_branches += 1
		else:
			possible_branches.erase(candidate)
func _gen_path(current: Vector2i, length: int, type: String) -> bool:
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
			level_layout[current_room.x][current_room.y] = type + str(length)
			if length > 1:
				possible_branches.append(current_room)
			if _gen_path(current_room, length - 1,  "R"):
				return true
			else:
				possible_branches.erase(current_room)
				level_layout[current_room.x][current_room.y] = 0
				current_room -= move_direction
		move_direction = Vector2i(move_direction.y, -move_direction.x)
	return false

func _print_layout() -> void:
	var layout : String = ""
	for y in range(_level_dimensions.y -1, -1, -1):
		for x in _level_dimensions.x:
			layout += '\t' + "[" + str(level_layout[x][y]) + "]" + '\t'
		layout += '\n'
	print(layout)

func _gen_start() -> void:
	if _start_room.x < 0 or _start_room.x >= _level_dimensions.x:
		_start_room.x = _rng.randi_range(0, _level_dimensions.x - 1)
	if _start_room.y < 0 or _start_room.y >= _level_dimensions.y:
		_start_room.y = _rng.randi_range(0, _level_dimensions.y - 1)
	level_layout[_start_room.x][_start_room.y] = "S"

func _initialize_level() -> void:
	for x in _level_dimensions.x:
		level_layout.append([])
		for y in _level_dimensions.y:
			level_layout[x].append(0)
