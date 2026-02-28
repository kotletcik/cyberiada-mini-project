extends Node

@export var shell_mesh: MeshInstance3D;

func _ready() -> void:
	EventBus.shells_appear.connect(set_shell_alpha.bind(true));
	EventBus.shells_disappear.connect(set_shell_alpha.bind(false));

func set_shell_alpha(visible: bool) -> void:
	var parent: Node3D = get_parent();
	parent.visible = visible;
