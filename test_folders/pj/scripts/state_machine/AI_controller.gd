extends NavigationAgent3D

@export var mob: CharacterBody3D
@export var move_speed := 2.0
@export var update_target_pos_timer: float = 1
var is_active: bool = true
var target_pos: Vector3

func _ready() -> void:
	mob = get_parent()
	target_pos = mob.position
	
func Physics_Update(delta: float):
	var destination = get_next_path_position()
	var local_destination = destination - $"../..".global_position
	var direction = local_destination.normalized()
	var _y_vel = mob.velocity.y
	mob.velocity = direction.normalized() * move_speed
	mob.velocity.y = _y_vel
	
func Set_target_position(pos: Vector3):
	set_target_position(pos)
	
func update_target_pos_every(_update_target_pos_timer: float):	
	Set_target_position(target_pos)
	await get_tree().create_timer(_update_target_pos_timer).timeout
	if is_active:
		update_target_pos_every(update_target_pos_timer)
