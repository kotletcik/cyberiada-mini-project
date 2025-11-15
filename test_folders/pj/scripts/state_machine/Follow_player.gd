extends State_with_target
class_name Follow_player

@onready var navigation_agent_3d: NavigationAgent3D = $"../../NavigationAgent3D"
@export var move_speed := 2.0
@export var update_target_pos_timer: float = 1
var player: CharacterBody3D
var mob: CharacterBody3D

func Enter():
	super.Enter()
	player = mob.player
	navigation_agent_3d.Set_target_position(player.position)

#func update_target_pos_every(_update_target_pos_timer: float):
	#Set_target_position(player.position)
	#await get_tree().create_timer(_update_target_pos_timer).timeout
	#if state_is_active:
		#update_target_pos_every(update_target_pos_timer)

#func Set_target_position(pos: Vector3):
	#navigation_agent_3d.set_target_position(pos)

#func Physics_Update(delta: float):
	#var destination = navigation_agent_3d.get_next_path_position()
	#var local_destination = destination - $"../..".global_position
	#var direction = local_destination.normalized()
	#var _y_vel = enemy.velocity.y
	#enemy.velocity = direction.normalized() * move_speed
	#enemy.velocity.y = _y_vel
