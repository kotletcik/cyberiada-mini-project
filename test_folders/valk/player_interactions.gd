class_name PlayerInteractions
extends Node3D

@export var interactRange: float = 5;

@onready var raycast: RayCast3D = RayCast3D.new();

@onready var camera: Camera3D = get_parent();
func _ready() -> void:
	add_child(raycast);
	raycast.global_position = global_position;


func _physics_process(delta: float) -> void:
	if(Input.is_action_just_pressed("Interact")):
		print("Global position: ", global_position);
		print("Raycats Global position: ", raycast.global_position);
		raycast.target_position = -basis.z * interactRange;
		raycast.force_update_transform();
		raycast.force_raycast_update();
		if(raycast.is_colliding()):
			var collisionNode: Node = raycast.get_collider();
			print(collisionNode.name);
			if(collisionNode.is_in_group("Serum")):
				print("meow");
				PsycheManager.instance.TakeSerum();
				collisionNode.queue_free();

