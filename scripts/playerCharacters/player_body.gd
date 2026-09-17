extends CharacterBody2D


const SPEED := 450.0
const DODGE_SPEED := 1000
const DODGE_COOLDOWN := 0.2 
const DODGE_RANGE := 0.2
const COLLISION_RADIUS : float = 65

var dodge_enabled : bool = true
var dodge_range : float = 0
var dodge_cooldown : float = 0
var dodge_direction = 0

var attack_type : String = "piercing_attack"

@onready var animation_player = $playerAnimations
@onready var animation_tree = $playerAnimationTree
@onready var state_machine = animation_tree["parameters/playback"]
@onready var attack_area = $attackArea

func _ready() -> void:
	animation_tree.active = true

func _physics_process(delta: float) -> void:
	if Input.is_key_pressed(KEY_1):
		attack_type = "piercing_attack"
	if Input.is_key_pressed(KEY_2):
		attack_type = "impact_attack"
	if Input.is_key_pressed(KEY_3):
		attack_type = "slash_attack"

	if dodge_range == 0.0:
		var movement_direction : Vector2 = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
		
		if movement_direction:
			velocity = movement_direction * SPEED
			animation_player.play("player_walk")
			attack_area.rotation = lerp_angle(attack_area.rotation, atan2(velocity.x, -velocity.y), delta*10.0)
		else:
			velocity.x = move_toward(velocity.x, 0, 45)
			velocity.y = move_toward(velocity.y, 0, 45)
			animation_player.play("player_idle")
	
	
	_dodge_logic(delta)
	_attack_logic()
	move_and_slide()
	animation_tree.set("parameters/movement/blend_position", (velocity.x || velocity.y))


func _attack_logic():
	if dodge_range == 0.0:
		if Input.is_action_just_pressed("attack"):
			state_machine.travel(attack_type)

func _dodge_logic(delta: float):
	var movement_direction : Vector2 = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	var collision = get_node("playerCollision")
	var radius = COLLISION_RADIUS
	if dodge_enabled == true and Input.is_action_just_pressed("dodge"):
		dodge_enabled = false
		
		collision.shape.set_radius(radius/2)
		
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
			collision.shape.set_radius(radius)
			
			dodge_enabled = true
