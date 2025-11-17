extends Node3D

@export var start_pos: = []
@export var attack_range: float = 0.5
@onready var nav_agent: NavigationAgent3D = $"NavigationAgent3D"
var player: PlayerController

func _ready() -> void:
	set_start_pos(1)
	EventBus.connect("game_restarted", set_start_pos)
	EventBus.connect("level_changed", set_start_pos)

func set_start_pos(level):
	position = start_pos[level-1]
	
func _enter_tree():
	player  = $"../Player"
