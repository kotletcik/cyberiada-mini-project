extends Node3D

var player: player_controller
@onready var nav_agent: NavigationAgent3D = $"NavigationAgent3D"

func _enter_tree():
	player  = $"../Player"
