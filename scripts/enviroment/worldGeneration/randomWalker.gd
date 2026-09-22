extends Node2D

@export var level_dimensions : Vector2i = Vector2i(4, 8)
var level_layout : Array

func _ready() -> void:
	_initialize_level()
	print(level_layout)


func _process(delta: float) -> void:
	pass

func _initialize_level() -> void:
	for x in level_dimensions.x:
		level_layout.append([])
		for y in level_dimensions.y:
			level_layout[x].append(0)
