extends Node
class_name Behaviour

@export_group("general")
@export var state_machine: State_machine
@export var player_sight_fov: float = 180
@export var player_sight_range: float = 2
@export var attack_range: float = 1.0
var timer: float
var stateIsActive: bool = true
@export var walls_layer: int


func is_player_in_sight() -> bool:
	if (state_machine != null):
		#var player_in_local: Vector3 = GameManager.instance.player.global_position - state_machine.mob.global_position;
		#var direction = player_in_local.normalized();
		#var dot: float = -state_machine.mob.global_basis.z.dot(direction);
		#if(dot < 1-(player_sight_fov/180)): 
		if (PsycheManager.instance.invisibility_timer > 0): return false;
		var col = raycast_xz_fov(
			state_machine.mob.global_position, 
			state_machine.mob.transform.basis.z * (-1), 
			player_sight_range, 
			player_sight_fov, 
			GameManager.instance.player.collision_layer | int(pow(2, walls_layer-1)))
		if col is CharacterBody3D:
			return true;
		else: return false
		#var isPlayerInRange: bool = (player_in_local).length() < player_sight_range;
		#return isPlayerInRange
	else: return false
	

# origin: punkt startowy promienia
# forward: kierunek „przodu” (Vector3)
# max_distance: maksymalna długość raycastu
# fov_deg: ograniczenie kąta widzenia w stopniach
# collision_mask: maska warstw kolizji
func raycast_xz_fov(origin: Vector3, forward: Vector3, max_distance: float = 100.0, fov_deg: float = 90.0, collision_mask: int = 0xFFFFFFFF) -> Node3D:
	var space_state = state_machine.mob.get_world_3d().direct_space_state
	
	# Kierunek w XZ
	var forward_xz = Vector3(forward.x, 0, forward.z).normalized()
	if forward_xz == Vector3.ZERO:
		return null
	
	# Tworzymy parametry raycastu
	var params = PhysicsRayQueryParameters3D.new()
	params.from = origin
	params.to = origin + forward_xz * max_distance
	params.exclude = []  # np. [self] jeśli chcesz wykluczyć siebie
	params.collision_mask = collision_mask
	params.collide_with_bodies = true
	params.collide_with_areas = true
	
	# Raycast
	var result = space_state.intersect_ray(params)
	if not result:
		return null
	
	var collider = result.collider
	if not collider:
		return null
	
	# Sprawdzenie kąta widzenia w XZ
	var dir_to_collider = (collider.global_position - origin)
	dir_to_collider.y = 0
	dir_to_collider = dir_to_collider.normalized()
	
	var angle = rad_to_deg(acos(forward_xz.dot(dir_to_collider)))
	if angle <= fov_deg / 2.0:
		return collider
	else:
		return null
