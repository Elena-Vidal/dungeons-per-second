extends Node2D

@onready var floors := %floors
@onready var walls := $walls

var _rng = RandomNumberGenerator.new()

func _ready() -> void:
	_generate_floor()

func _generate_floor() -> void:
	var floor_type := _rng.randi_range(0, floors.get_child_count(false)-1)
	print(floor_type)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
