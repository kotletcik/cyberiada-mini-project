extends State
class_name Wander

@export var empty_target: Node3D
@export var wander_radius: float = 5
var player: CharacterBody3D

	
func _ready() -> void:
	player = state_machine.mob.player
	
func Enter():
	super.Enter()
	nav_agent.target = empty_target
	randomize_wander()

func Update (delta: float):	
	randomize_wander()
	empty_target.global_position = empty_target.global_position

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
