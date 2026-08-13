extends CharacterBody2D


const SPEED := 450.0
const DODGE_SPEED := 700
const DODGE_COOLDOWN := 0.8
const DODGE_RANGE := 0.2

var dodge_enabled : bool = true
var dodge_range : float = 0
var dodge_cooldown : float = 0
var dodge_direction : int = 0

func _physics_process(delta: float) -> void:

	var movement_direction : Vector2 = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	
	if movement_direction:
		velocity = movement_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 45)
		velocity.y = move_toward(velocity.y, 0, 45)
	
	if Input.is_action_just_pressed("dodge"):
		print("dodge")
	
	move_and_slide()
