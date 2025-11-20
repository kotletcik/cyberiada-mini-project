extends Node3D

@onready var player: CharacterBody3D = $"../"
@onready var animator: AnimationPlayer = $"../AnimationPlayer"
@export var animation_running_name: String
@export var animation_idle_name: String

func set_rotation_to_movement_direction():
	if player.velocity != Vector3.ZERO:
		var move_direction = Vector3(player.velocity.x, 0, player.velocity.z).normalized()
		rotation.y = atan2(move_direction.x, move_direction.z)
		
func _physics_process(delta: float) -> void:
	if player.velocity.length() > 1:
		animator.play(animation_running_name)
	if player.velocity.length() <= 1:
		animator.play(animation_idle_name)
	
	set_rotation_to_movement_direction()
