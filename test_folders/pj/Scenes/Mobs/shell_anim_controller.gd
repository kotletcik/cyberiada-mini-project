extends Node3D

@onready var mob: CharacterBody3D = $"../"

func _physics_process(delta: float):
	set_rotation_to_movement_direction()
	
func set_rotation_to_movement_direction():
	if mob.velocity != Vector3.ZERO:
		var move_direction = Vector3(mob.velocity.x, 0, mob.velocity.z).normalized()
		rotation.y = atan2(move_direction.x, move_direction.z)
