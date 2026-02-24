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
		var player_in_local: Vector3 = GameManager.instance.player.global_position - state_machine.mob.global_position;
		var direction = player_in_local.normalized();
		var dot: float = -state_machine.mob.global_basis.z.dot(direction);
		if (self is Mutation_behaviour):
			print (player_in_local.length())
		if(dot < 1-(player_sight_fov/180)): 
			return false;
		var isPlayerInRange: bool = (player_in_local).length() < player_sight_range;
		return isPlayerInRange
	else: return false
