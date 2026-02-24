extends State
class_name Patrol

@export var empty_target: Node3D
@export var patrol_points:=[]
var player: CharacterBody3D
var current_target_pos: int = 0

	
func _ready() -> void:
	player = state_machine.mob.player
	
func Enter():
	super.Enter()
	state_machine.nav_agent.target = empty_target
	update_patrol_target_pos()

func Update (delta: float):
	if (((state_machine.mob.position - patrol_points[current_target_pos]).length()) <= 3):
		update_patrol_target_pos()
	empty_target.global_position = empty_target.global_position

func update_patrol_target_pos():
	empty_target.position = next_pos(current_target_pos)
	print(patrol_points[current_target_pos])
	
	
func next_pos(curr_pos_number) -> Vector3:
	if (curr_pos_number >= patrol_points.size() - 1):
		current_target_pos = 0
	else: current_target_pos += 1
	return patrol_points[current_target_pos]
