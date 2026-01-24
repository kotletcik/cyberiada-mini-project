extends Node3D
class_name shell

@export var start_pos: = []
@export var attack_range: float = 0.5
@export var player_sight_range: float = 2
@export var player_sight_fov: float = 180
@onready var nav_agent: NavigationAgent3D = $"NavigationAgent3D"
var player: PlayerController
@onready var state_machine: State_machine = $"State_machine"

# func _ready() -> void:
# 	set_start_pos(1)
# 	EventBus.connect("game_restarted", set_start_pos)
# 	EventBus.connect("level_changed", set_start_pos)

# func set_start_pos(level):
# 	var _level=level
# 	if !_level:
# 		_level = Game_Manager.current_level
# 	if _level-1 < start_pos.size() and _level-1>=0:
# 		position = start_pos[_level-1]
	
func _enter_tree():
	player  = $"../Player"

func is_player_in_sight() -> bool:
	var subtracted_vector: Vector3 = player.position - state_machine.mob.position;
	var direction = subtracted_vector.normalized();
	var dot: float = -state_machine.mob.global_basis.z.dot(direction);
	if(dot < 1-(player_sight_fov/180)): return false;
	return ((state_machine.mob.position) - (player.position)).length() < state_machine.mob.player_sight_range;
