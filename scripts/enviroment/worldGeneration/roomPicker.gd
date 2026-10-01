extends Node2D

@onready var floor_list := $floors
@onready var wall_list := $walls

var _rng = RandomNumberGenerator.new()

func _ready() -> void:
	_generate_room([1,0,0,0])

func _generate_room(doors: Array[int]) -> void:
	var walls := wall_list.get_children(false)
	var floors := floor_list.get_children(false)
	var wall_types_total := walls[0].get_child(0, false).get_child_count(false)-2
	var floor_types_total := floors.size()-1
	
	var wall_type := _rng.randi_range(0, wall_types_total)
	var floor_type := _rng.randi_range(0, floor_types_total)
	
	floors[floor_type].visible = true
	
	for i in walls.size():
		print(i)
		print(walls.size())
		print(walls[i].get_children())
	for i in 1:#doors.size():
		var current_side : Node2D
		if doors[i] == 1:
			current_side = walls[i].get_child(0)
		else:
			current_side = walls[i].get_child(1) 
		current_side.get_child(wall_type).visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
