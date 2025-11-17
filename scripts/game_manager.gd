extends Node3D

@export var player: CharacterBody3D
@export var shells = []

func _ready() -> void:
	EventBus.connect("game_restarted", restart_game)

func restart_game(level: int):
	player.position = player.start_pos[level]
	shells[0].position = player.start_pos[level]
