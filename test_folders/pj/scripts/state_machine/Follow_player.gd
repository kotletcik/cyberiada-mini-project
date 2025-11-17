extends State
class_name Follow_player

@export var player: CharacterBody3D
var timer:= 5.0
var time = timer

func _ready() -> void:
	player = state_machine.mob.player

func Enter():
	super.Enter()
	nav_agent.target = player

func Update(delta: float):
	nav_agent.set_target_position(player.position)
	if time > 0:
		time-=delta
	else:
		change_state_to("wander")
		time = timer
	
