extends State
class_name Follow_sound

@export var follow_target: Node3D
var player: CharacterBody3D

func _ready() -> void:
	EventBus.connect("sound_emitted_by_player", Set_sound_as_target)

func Enter():
	super.Enter()
	follow_target.position = state_machine.target
	nav_agent.target = follow_target
	player = state_machine.mob.player;

func Set_sound_as_target(sound_pos: Vector3):
	state_machine.target = sound_pos

func Update(delta: float):
	nav_agent.set_target_position(follow_target.position)
	
