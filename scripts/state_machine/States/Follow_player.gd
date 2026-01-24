extends State
class_name Follow_player

@export var player: CharacterBody3D
@export var follow_state_duration:= 5.0
var timer:= follow_state_duration
var time = timer

func _ready() -> void:
	player = state_machine.mob.player

func Enter():
	super.Enter()
	nav_agent.target = player
	timer = follow_state_duration

func Update(delta: float):
	nav_agent.set_target_position(player.position)
	if ((state_machine.mob.position) - (player.position)).length() < state_machine.mob.attack_range:
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
	if(PsycheManager.instance.invisibility_timer > 0):
		change_state_to("wander")
	

	
