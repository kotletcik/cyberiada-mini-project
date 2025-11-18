extends CharacterBody3D
class_name player_controller
 
@export var start_pos: = []
@export var move_speed = 5.0

func _ready() -> void:
	set_start_pos(1)
	EventBus.connect("game_restarted", set_start_pos)
	EventBus.connect("level_changed", set_start_pos)

func set_start_pos(level):
	position = start_pos[level-1]

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
	
func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == Key.KEY_SPACE:
			EventBus.emit_signal("sound_emitted_by_player")
		if event.pressed and event.keycode == Key.KEY_1:
			EventBus.level_changed.emit(1)
		if event.pressed and event.keycode == Key.KEY_2:
			EventBus.level_changed.emit(2)
		if event.pressed and event.keycode == Key.KEY_3:
			EventBus.level_changed.emit(3)
