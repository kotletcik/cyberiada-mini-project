extends Camera3D

@export var start_pos: = []

func _ready() -> void:
	set_start_pos(1)
	EventBus.connect("game_restarted", set_start_pos)
	EventBus.connect("level_changed", set_start_pos)

func set_start_pos(level):
	position = start_pos[level-1]
