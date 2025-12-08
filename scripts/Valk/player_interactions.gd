extends Node3D

@export var serum: PackedScene 

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	if(Input.get_action_strength("Interact") == 1.0):
		var forward: Vector3 = -get_global_transform().basis.z;
		# forward = forward * -get_global_transform_interpolated().basis.z 
		print(forward);
		var query = PhysicsRayQueryParameters3D.create(position, position + forward * 10);
		var collision = get_world_3d().direct_space_state.intersect_ray(query);
		
		print(collision.is_empty());
		if(!collision.is_empty()):
			var instance: Node3D = serum.instantiate();
			# add_child(instance);
			instance.owner = get_tree().edited_scene_root;
			instance.global_position = collision["position"];
			var object: Node3D = collision["collider"];
			print(object.name);
			if(object.is_in_group("Serum")):
				PsycheManager.instance.take_serum();
				object.queue_free();
