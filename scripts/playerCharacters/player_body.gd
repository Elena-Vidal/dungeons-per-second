extends CharacterBody2D


const SPEED := 450.0
const DODGE_SPEED := 1000
const DODGE_COOLDOWN := 0.2 
const DODGE_RANGE := 0.2
const COLLISION_SIZE : Vector2 = Vector2(128, 128)

var dodge_enabled : bool = true
var dodge_range : float = 0
var dodge_cooldown : float = 0
var dodge_direction = 0

@onready var animation_player = $playerAnimations
@onready var attack_area = $slashAttack

func _physics_process(delta: float) -> void:
	if dodge_range == 0.0:
		var movement_direction : Vector2 = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
		
		if movement_direction:
			velocity = movement_direction * SPEED
			attack_area.rotation = lerp_angle(attack_area.rotation, atan2(velocity.x, -velocity.y), delta*10.0)
		else:
			velocity.x = move_toward(velocity.x, 0, 45)
			velocity.y = move_toward(velocity.y, 0, 45)
		if Input.is_action_just_pressed("attack"):
			animation_player.play("slash_attack_anim")
	
	_dodge_logic(delta)
	move_and_slide()


func _dodge_logic(delta: float):
	var movement_direction : Vector2 = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	var collision = get_node("playerCollision")
	var size = COLLISION_SIZE
	if dodge_enabled == true and Input.is_action_just_pressed("dodge"):
		dodge_enabled = false
		
		collision.shape.set_size(size/2)
		
		dodge_direction = movement_direction
		dodge_cooldown = DODGE_COOLDOWN
		dodge_range = DODGE_RANGE
		velocity = dodge_direction * DODGE_SPEED
		
	
	if dodge_range > 0.0:
		dodge_range = max(0.0, dodge_range - delta)
	else:
		if dodge_cooldown > 0.0:
			dodge_cooldown -= delta
		else:
			collision.shape.set_size(size)
			
			dodge_enabled = true


func _on_slash_attack_body_entered(body: Node2D) -> void:
	print("attack")
	pass # Replace with function body.
