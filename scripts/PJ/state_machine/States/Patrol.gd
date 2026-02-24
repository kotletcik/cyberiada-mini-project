extends State
class_name Patrol

@export var empty_target: Node3D
@export var patrol_points: Array[Node3D]
var current_target_pos: int = 0
	
func Enter():
	super.Enter()
	state_machine.nav_agent.target = empty_target
	change_target_to_next_pos()

func Update (delta: float):
	if (((state_machine.mob.position - patrol_points[current_target_pos].global_position).length()) <= 3):
		change_target_to_next_pos()
	empty_target.global_position = empty_target.global_position
	
func change_target_to_next_pos():
	if (current_target_pos >= patrol_points.size() - 1):
		current_target_pos = 0
	else: current_target_pos += 1
	empty_target.global_position = patrol_points[current_target_pos].position
