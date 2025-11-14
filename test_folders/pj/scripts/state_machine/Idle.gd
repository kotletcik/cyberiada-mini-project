extends State
class_name Idle

@export var mob: CharacterBody3D
@export var move_speed:= 10.0

var move_direction: Vector3
var wander_time: float

func randomize_wander():
	move_direction = Vector3(randf_range(-1, 1),0,randf_range(-1, 1))
	wander_time = randf_range(1,3)

func Enter():
	randomize_wander()
	
func Update (delta: float):
	#print ("update")
	if wander_time > 0:
		wander_time-=delta
	else:
		randomize_wander()
		
func Physics_Update(_delta: float):
	if mob:
		mob.velocity = move_direction * move_speed
		
