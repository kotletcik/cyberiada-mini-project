extends CharacterBody3D
class_name PlayerController


@export var start_pos: = []
@export var move_speed = SOBER_WALK_SPEED

#movement
var speed
const SOBER_WALK_SPEED = 5.0
const SUBSTANCE_WALK_SPEED = 8.0
const SENSITIVITY = 0.004


#bobbing
const BOB_FREQ = 2.4
const BOB_AMP = 0.08
var t_bob = 0.0

var last_frame_mouse_pos: Vector3
var mouse_input: Vector2

@onready var head = $Head
@onready var camera = $Head/Camera3D

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
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	
	#bobbing
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)

	# zastosowanie ruchu
	move_and_slide()

	#obrot kamery w kierunku ruchu
	if input_dir != Vector3.ZERO:
		look_at(position + direction, Vector3.UP)


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

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
