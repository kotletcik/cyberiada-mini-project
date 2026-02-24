extends Node
class_name Behaviour

@export_group("general")
@export var state_machine: State_machine
@export var player_sight_fov: float = 180
@export var player_sight_range: float = 2
@export var attack_range: float = 0.5
var player: PlayerController
var timer: float
var time: float
var stateIsActive: bool = true


func is_player_in_sight() -> bool:
	if (state_machine != null):
		var subtracted_vector: Vector3 = state_machine.mob.player.position - state_machine.mob.position;
		var direction = subtracted_vector.normalized();
		var dot: float = -state_machine.mob.global_basis.z.dot(direction);
		if(dot < 1-(player_sight_fov/180)): return false;
		var isPlayerInRange: bool = ((state_machine.mob.position) - (state_machine.mob.player.position)).length() < player_sight_range;
		return isPlayerInRange
	else: return false
