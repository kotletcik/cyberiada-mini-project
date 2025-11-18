class_name GameManager
extends Node3D

static var instance: GameManager

@export var player: CharacterBody3D
@export var shells = []

func _ready() -> void:
	if(instance == null):
		instance = self;
		EventBus.connect("game_restarted", restart_game);
	else:
		print("More than one GameManager exists!!!");
		queue_free();


func restart_game(level: int):
	player.position = player.start_pos[level]
	shells[0].position = player.start_pos[level]
