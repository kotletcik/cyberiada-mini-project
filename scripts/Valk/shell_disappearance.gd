extends Node

@export var shell_mesh: MeshInstance3D;

func _ready() -> void:
	EventBus.shells_appear.connect(set_shell_alpha.bind(1.0));
	EventBus.shells_disappear.connect(set_shell_alpha.bind(0.0));

func set_shell_alpha(alpha: float) -> void:
	shell_mesh.get_surface_override_material(0).albedo_color.a = alpha;
