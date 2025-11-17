extends State
class_name Wander

@export var empty_target: Node3D
@export var wander_time: float = 10.0
var timer: float
	
func randomize_wander():
	empty_target.position = _random_pos_in_current_region()
	#nav_agent.target_pos = state_machine.mob.position + Vector3(randf_range(-1, 1),0,randf_range(-1, 1))
	nav_agent.move_speed = move_speed
	
func _random_pos_in_current_region() -> Vector3:
	return state_machine.mob.global_position + Vector3(\
	randf_range(-2, 2),\
	state_machine.mob.global_position.y, \
	randf_range(-2, 2))
	
func Enter():
	super.Enter()
	EventBus.connect("sound_emitted_by_player", change_state_to_follow)
	print("empty_target_setted")
	nav_agent.target = empty_target
	randomize_wander()

func Update (delta: float):
	if timer > 0:
		timer-=delta
	else:
		randomize_wander()
		timer = wander_time 
	empty_target.global_position = empty_target.global_position

func change_state_to_follow():
	change_state_to("follow_player")

func Exit():
	super.Exit()
	EventBus.disconnect("sound_emitted_by_player", change_state_to_follow)
