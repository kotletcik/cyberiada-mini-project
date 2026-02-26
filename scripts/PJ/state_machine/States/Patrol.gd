extends State
class_name Patrol

@export var empty_target: Node3D
@export var patrol_points: Array[Node3D]
@export var patrol_point_waiting_time:= 3.0
var current_target_pos: int = 0
var is_Staying: bool = false
var timer:= 0.0
	
func Enter():
	super.Enter()
	state_machine.nav_agent.target = empty_target
	change_target_to_next_pos()


func Update (delta: float):
	if (((state_machine.mob.position - patrol_points[current_target_pos].global_position).length()) <= 1 && !is_Staying):
		timer = patrol_point_waiting_time
		state_machine.nav_agent.move_speed = 0
		change_target_to_next_pos()
		is_Staying = true
	elif (is_Staying):
		if (timer < 0):
			state_machine.nav_agent.move_speed = move_speed
			is_Staying = false
		else: timer -= delta
	empty_target.global_position = empty_target.global_position
	
func change_target_to_next_pos():
	if (current_target_pos >= patrol_points.size() - 1):
		current_target_pos = 0
	else: current_target_pos += 1
	empty_target.global_position = patrol_points[current_target_pos].position
