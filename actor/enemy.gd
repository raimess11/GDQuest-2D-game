extends "res://actor/actor.gd"

export var score = 100

func _ready() -> void:
	set_physics_process(false)
	move.x = -speed.x

func _on_stompdetector_body_entered(body: PhysicsBody2D) -> void:
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	die()

func _physics_process(delta: float) -> void:
	move.y += gravity * delta
	
	if is_on_wall():
		move.x *= -1
	
	move.y = move_and_slide(move, FLOOR_NORMAL).y

func die() -> void:
	queue_free()
	PlayerData.score += score
