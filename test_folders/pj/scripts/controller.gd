extends CharacterBody3D

@export var move_speed: float = 5.0

func _physics_process(delta: float) -> void:
	var input_dir = Vector3.ZERO
	
	input_dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_dir.z = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	
	if input_dir != Vector3.ZERO:
		input_dir = input_dir.normalized()
	
	# kierunek w przestrzeni świata
	var direction = (transform.basis * input_dir).normalized()
	
	# ustawienie prędkości poziomej
	velocity.x = direction.x * move_speed
	velocity.z = direction.z * move_speed
	
	# zastosowanie ruchu
	move_and_slide()
