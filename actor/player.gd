extends actor

export var stomp_impuls: = 1000.0


func _on_Area2D_area_entered(area: Area2D) -> void:
	move = get_impuls_vector(move, stomp_impuls)
	


func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
	die()

func _physics_process(_delta: float) -> void:
	var is_jump_interrupted = Input.is_action_just_released("jump") and move.y < 0.0
	var direction = player_control()
	move = get_move_vector(move, direction, speed, is_jump_interrupted)
	move = move_and_slide(move, FLOOR_NORMAL) 


func player_control() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)

func get_move_vector(
		linear_move: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var new_move = linear_move
	new_move.x = speed.x * direction.x
	new_move.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		new_move.y = speed.y * direction.y
	if is_jump_interrupted:
		new_move.y = 0.0
	return  new_move
	
func get_impuls_vector(linear_move: Vector2, stomp_impuls: float) -> Vector2:
	var new_move = linear_move
	new_move.y = -stomp_impuls
	return new_move

func die() -> void:
	PlayerData.died += 1
	queue_free()
