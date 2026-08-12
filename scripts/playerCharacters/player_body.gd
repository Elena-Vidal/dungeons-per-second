extends CharacterBody2D


const SPEED = 600.0

var dodgeCooldown = true
var lastDirection = Vector2(0, 0)

func _physics_process(delta: float) -> void:

	var directionX := Input.get_axis("moveLeft", "moveRight")
	var directionY := Input.get_axis("moveUp", "moveDown")
	if directionX:
		if dodgeCooldown == false:
			velocity.x = SPEED
		else:
			velocity.x = directionX * SPEED
		#lastDirection.x = directionX
	else:
		#lastDirection.x = 0
		velocity.x = move_toward(velocity.x, 0, 60)
	if directionY:
		velocity.y = directionY * SPEED
		#lastDirection.y = directionY
	else:
		lastDirection.y = 0
		#velocity.y = move_toward(velocity.y, 0, 60)

	if Input.is_action_just_pressed("dodge") and dodgeCooldown and velocity.x != 0 and velocity.y != 0:
		dodge()
	print(position)
	print(sign(position))

	move_and_slide()

func dodge():
	dodgeCooldown = false
	var timer:SceneTreeTimer = get_tree().create_timer(0.5)
	var collision = get_node("playerCollision")
	velocity *= 5
	collision.set_deferred("disable_mode", true)
	timer.timeout.connect(set.bind("dodgeCooldown", true))
	velocity /= 5
	collision.set_deferred("disabled_mode", false)
