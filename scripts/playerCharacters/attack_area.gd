extends Area2D

@onready var playerRoot := %playerBody
@onready var cooldown := $attackCooldown
@onready var tree := get_tree()
#
#func _physics_process(delta: float) -> void:
	#if playerRoot.animation_player.current_animation == "piercing_attack":
		#cooldown.start()

func _on_body_entered(body: Node2D) -> void:
	print(body)
	print(body.get_groups())
	if body.is_in_group("enemies"):
		body.queue_free()
#
#func _on_attack_cooldown_timeout() -> void:
	#playerRoot.state_machine.travel("movement")
