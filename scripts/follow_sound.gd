extends State
class_name Follow_sound

@export var follow_state_duration:= 2.0
@onready var follow_target: Node3D = $Empty_target
var timer:= follow_state_duration
var time = timer

func Enter():
	super.Enter()
	follow_target.position = state_machine.target
	nav_agent.target = follow_target
	timer = follow_state_duration
	# Valk: dodałem aby potwór szedł do najnowszego dzwięku
	EventBus.connect("sound_emitted_by_player", change_state_to_follow_sound)

func change_state_to_follow_sound(sound_pos: Vector3):
	state_machine.target = sound_pos
	change_state_to("follow_sound")

func Update(delta: float):
	nav_agent.set_target_position(follow_target.position)
	if ((state_machine.mob.position) - (follow_target.position)).length() < state_machine.mob.attack_range:
		#var _timer = get_tree().create_timer(0.5)
		#await _timer.timeout
		time = timer
		change_state_to("wander")
		#change_state_to("wander")
	elif time > 0:
		time-=delta
	else:
		change_state_to("wander")
		time = timer
	
