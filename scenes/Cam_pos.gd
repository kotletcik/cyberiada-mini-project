extends Camera3D

@export var start_pos: = []

#func _ready() -> void:
	
	

func set_start_pos(level):
	position = start_pos[level-1]
