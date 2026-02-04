extends State
class_name Wander

@export var empty_target: Node3D
@export var wander_time: float = 10.0
@export var wander_radius: float = 5
var timer: float
var player: CharacterBody3D

	
func _ready() -> void:
	player = state_machine.mob.player

func randomize_wander():
	empty_target.position = random_pos_in_range(wander_radius)
	#nav_agent.target_pos = state_machine.mob.position + Vector3(randf_range(-1, 1),0,randf_range(-1, 1))
	nav_agent.move_speed = move_speed
	
func random_pos_in_current_region() -> Vector3:
	return state_machine.mob.global_position + Vector3(\
	randf_range(-2, 2),\
	state_machine.mob.global_position.y, \
	randf_range(-2, 2))
	
func random_pos_in_range(range: float) -> Vector3:
	var alfa : float = randf() * (2*PI)
	return state_machine.mob.global_position + Vector3(\
	range, 0, 0) * cos(alfa) + Vector3(\
	0, 0, range) * sin(alfa)
	
func Enter():
	super.Enter()
	EventBus.connect("sound_emitted_by_player", change_state_to_follow_sound)
	nav_agent.target = empty_target
	randomize_wander()

func Update (delta: float):
	if (state_machine.mob.is_player_in_sight()):
		if (PsycheManager.instance.invisibility_timer <= 0): change_state_to("follow_player");
	if timer > 0:
		timer -= delta
	else:
		randomize_wander()
		timer = wander_time 
	empty_target.global_position = empty_target.global_position

func change_state_to_follow_sound(sound_pos: Vector3):
	state_machine.target = sound_pos
	change_state_to("follow_sound")

func change_state_to_follow():
	change_state_to("follow_player")

func Exit():
	super.Exit()
	EventBus.disconnect("sound_emitted_by_player", change_state_to_follow_sound)
