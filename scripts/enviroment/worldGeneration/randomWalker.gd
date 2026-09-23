extends Node2D

@export var _level_dimensions : Vector2i = Vector2i(4, 8)
@export var _start_room : Vector2i
var level_layout : Array

var _rng = RandomNumberGenerator.new()

func _ready() -> void:
	_initialize_level()
	_special_rooms(level_layout, _level_dimensions)
	_print_layout(level_layout)


func _process(delta: float) -> void:
	pass

func _print_layout(level: Array) -> void:
	for i in level.size()-1:
		print(level[i], '\n')


func _special_rooms(level: Array, size: Vector2i) -> void:
	var start := Vector2i(-1, -1)
	var end := Vector2i(-1, -1)
	var item : Array[Vector2i]
	#var location : Vector2i
	var different : bool = false
	
	item.resize(_rng.randi_range(1, 3))
	
	start = Vector2i(_rng.randi_range(0, size.x), _rng.randi_range(0, size.y))
	end = Vector2i(_rng.randi_range(0, size.x), _rng.randi_range(0, size.y))
	while start == end:
		start = Vector2i(_rng.randi_range(0, size.x), _rng.randi_range(0, size.y))
		end = Vector2i(_rng.randi_range(0, size.x), _rng.randi_range(0, size.y))
	for i in item.size()-1:
		item[i] = Vector2i(_rng.randi_range(0, size.x), _rng.randi_range(0, size.y))
		while item[i] == item[i-1] or item[i] == start or item[i] == end:
			item[i] = Vector2i(_rng.randi_range(0, size.x), _rng.randi_range(0, size.y))
	
	level[start.x][start.y] = 1
	level[end.x][end.y] = 2
	for i in item.size()-1:
		level[item[i].x][item[i].y] = 8

func _initialize_level() -> void:
	for x in _level_dimensions.x:
		level_layout.append([])
		for y in _level_dimensions.y:
			level_layout[x].append(0)
