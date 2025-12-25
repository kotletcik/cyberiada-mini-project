extends StaticBody3D

@export var group_name: String;

func _ready() -> void:
	add_to_group(group_name);
	if(group_name == "Serum"):
		PsycheManager.instance.register_serum_position(global_position);
