class_name GameManager
extends Node3D

static var instance: GameManager
var current_level = 1;

@export var player: CharacterBody3D
@export var shells = []

func _ready() -> void:
	if (instance == null):
		instance = self;
		EventBus.connect("game_restarted", change_level_to);
		EventBus.connect("level_changed", change_level_to);
	else:
		print("More than one GameManager exists!!!");
		queue_free();

func _input(event):
	# if event is InputEventKey:
	# 	if event.pressed and event.keycode == Key.KEY_1:
	# 		EventBus.level_changed.emit(1)
	# 	if event.pressed and event.keycode == Key.KEY_2:
	# 		EventBus.level_changed.emit(2)
	# 	if event.pressed and event.keycode == Key.KEY_3:
	# 		EventBus.level_changed.emit(3)
	# 	if event.pressed and event.keycode == Key.KEY_4:
	# 		EventBus.level_changed.emit(4)
	# 	if event.pressed and event.keycode == Key.KEY_5:
	# 		EventBus.level_changed.emit(5)
	pass

#func restart_game(level: int):
	#player.position = player.start_pos[level]
	#shells[0].position = player.start_pos[level]
	
func change_level_to(level:int):
	if !level:
		current_level = level
