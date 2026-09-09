extends Area2D

@onready var player := %playerBody
@onready var animation := %playerBody/playerAnimations

func _on_body_entered(body: Node2D) -> void:
	if animation.current_animation == "attack_pierce" and animation.is_playing():
		print(player.COLLISION_SIZE)
