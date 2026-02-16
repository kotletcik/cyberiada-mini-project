extends State
class_name Follow_player

@export var player: CharacterBody3D


func _ready() -> void:
	player = state_machine.mob.player

func Enter():
	super.Enter()
	state_machine.nav_agent.target = player

func Update(delta: float):
	state_machine.nav_agent.set_target_position(player.position)
