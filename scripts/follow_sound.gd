extends State
class_name Follow_sound

@export var follow_state_duration:= 5.0
var follow_target: Vector3
var timer:= follow_state_duration
var time = timer

func Enter():
	super.Enter()
	nav_agent.target = follow_target
	timer = follow_state_duration

func Update(delta: float):
	nav_agent.set_target_position(follow_target)
	if ((state_machine.mob.position) - (follow_target)).length() < state_machine.mob.attack_range:
		#var _timer = get_tree().create_timer(0.5)
		#await _timer.timeout
		time = timer
		change_state_to("attack")
		#change_state_to("wander")
	elif time > 0:
		time-=delta
	else:
		change_state_to("wander")
		time = timer
	
