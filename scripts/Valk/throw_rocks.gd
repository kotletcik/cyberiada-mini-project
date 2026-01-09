extends Node

@export var throw_position: Node3D;
@export var throw_force: float;
@export var rock: Resource;

func _physics_process(delta: float) -> void:
	if(Input.is_action_just_pressed("use_item_2")):
		# if(!InventoryManager.instance.has_item(ITEM_TYPE.ROCK)): return;
		# InventoryManager.instance.remove_item(ITEM_TYPE.ROCK, 1);
		var rock_instance = rock.instantiate();
		rock_instance.player_pos = throw_position.global_position;
		get_tree().get_current_scene().add_child(rock_instance);
		rock_instance.global_position = throw_position.global_position;
		rock_instance.global_rotation = throw_position.global_rotation;
		rock_instance.apply_central_impulse(-rock_instance.basis.z * throw_force);
