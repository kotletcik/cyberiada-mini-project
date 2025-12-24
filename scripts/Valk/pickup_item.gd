extends StaticBody3D

@export var group_name: String;

func _ready() -> void:
	add_to_group(group_name);
