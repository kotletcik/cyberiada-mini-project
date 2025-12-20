extends Node3D

@export var serum: PackedScene 

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("Interact")):
		var forward: Vector3 = -get_global_transform().basis.z;
		# forward = forward * -get_global_transform_interpolated().basis.z 
		# print("Position: " , global_position);
		# print("forward: " , forward);
		# print("p + f: " , global_position + forward * 10);
		var query = PhysicsRayQueryParameters3D.create(global_position, global_position + forward * 10);
		var collision = get_world_3d().direct_space_state.intersect_ray(query);
		
		print(collision.is_empty());
		if(!collision.is_empty()):
			var object: Node3D = collision["collider"];
			print(object.name);
			if(object.is_in_group("Serum")):
				InventoryManager.instance.add_item(ITEM_TYPE.SERUM, 1);
				object.queue_free();
