extends Node3D
class_name shell

@export var start_pos: = []
@export var attack_range: float = 0.5
@onready var nav_agent: NavigationAgent3D = $"NavigationAgent3D"
var player: PlayerController

func _ready() -> void:
	set_start_pos(1)
	EventBus.connect("game_restarted", set_start_pos)
	EventBus.connect("level_changed", set_start_pos)

func set_start_pos(level):
	var _level=level
	if !_level:
		_level = Game_Manager.current_level
	if _level-1 < start_pos.size() and _level-1>=0:
		position = start_pos[_level-1]
	
func _enter_tree():
	player  = $"../Player"
