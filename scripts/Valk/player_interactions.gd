extends Node3D


func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	if(Input.get_action_strength("Interact") == 1.0):
		var forward: Vector3 = -get_global_transform().basis.z;
		var query = PhysicsRayQueryParameters3D.create(position, position + forward * 10);
		var collision = get_world_3d().direct_space_state.intersect_ray(query);
		print(collision.is_empty());
		if(!collision.is_empty()):
			var object: Node3D = collision["collider"];
			print(object.name);
