class_name PsycheManager
extends Node

static var instance: PsycheManager;

var serum_level: float;
var fog_fade_level: float;
@export var player: Node3D;
@export var serum_drop_rate: float;
@export var serum_start_level: float;

@export var normal_fog_density: float;
@export var serum_fog_density: float;

@export var serum_take_amount: float;

@export var serum_overdose_level: float;
@export var serum_critical_level: float;

@export var serum_to_normal_fog_speed: float;

@export var serum_invisibility_time: float;

@export_group("Fog Fade On Serum")
@export var fog_fade_drop_rate: float;
@export var fog_fade_start_level: float;
@export var fog_fade_addiction_addition: float;

@export_group("Overtake")
@export var min_overtake_timer: float;
@export var max_overtake_timer: float;
@export var overtake_player_force: float;

@export_group("Craving")
@export var min_craving_timer: float;
@export var max_craving_timer: float;
@export var craving_player_force: float;
@export var craving_serum_take_radius: float;
@export var craving_serum_fov: float;

@export_group("Saturation")
@export var serum_to_normal_saturation_speed: float;
@export var normal_saturation: float;
@export var overdose_saturation: float;
@export var critical_saturation: float;

@export_group("Vignette")
@export var serum_to_normal_vignette_speed: float;

@export_subgroup("Default Take Vignette")
@export var serum_vignette_intensity: float;
@export var serum_vignette_color: Color;
@export var serum_vignette_radius: float;

@export_subgroup("Overdose Take Vignette")
@export var serum_overdose_vignette_intensity: float;
# @export var serum_to_normal_overdose_vignette_speed: float;
@export var serum_overdose_vignette_color: Color;
@export var serum_overdose_vignette_radius: float;

@export_subgroup("Critical Take Vignette")
@export var serum_critical_vignette_intensity: float;
# @export var serum_to_overdose_critical_vignette_speed: float;
@export var serum_critical_vignette_color: Color;
@export var serum_critical_vignette_radius: float;

# @onready var camera: Camera3D = player.get_child(0).get_child(0);
@onready var camera: Camera3D = $"../Player/Head/Camera3D";
@onready var vignette_texture: TextureRect = $"../Player/CanvasLayer/TextureRect";
@onready var saturation_texture: TextureRect = $"../Player/CanvasLayer/TextureRect2";
@onready var base_camera_fov: float = camera.fov;
@onready var environment: Environment = camera.environment;


var serum_positions: Array[Vector3] = [Vector3.ZERO];
var serums: Array[Node3D] = [null];

var first_free_index: int = 0;

var invisibility_timer: float = 0;

var craving_timer: float;
var overtake_timer: float;
var overtake_dir: Vector3;

func register_serum(node: Node3D, pos: Vector3) -> void:
	serums[first_free_index] = node;
	serum_positions[first_free_index] = pos;
	first_free_index += 1;
	if(serums.size() == first_free_index):
		serums.resize(first_free_index * 2);
		serum_positions.resize(first_free_index * 2);

func unregister_serum(node: Node3D) -> void:
	for i in range(0, first_free_index):
		if(serums[i] == node):
			serum_positions.remove_at(i);
			serums.remove_at(i);
			break;
	if(first_free_index > 0):
		first_free_index -= 1;


# func register_camera(registered_camera: Camera3D) -> void:
# 	camera = registered_camera;

func _ready() -> void:
	if(instance == null):
		instance = self;
		base_camera_fov = camera.fov;
		environment = camera.environment;
		print("Camera FOV: ", camera.fov);
		environment.fog_density = normal_fog_density;
		camera  = player.get_child(0).get_child(0);
		vignette_texture.material.set_shader_parameter("intensity", 0);
		saturation_texture.material.set_shader_parameter("saturation", normal_saturation);
		serum_level = serum_start_level;
		fog_fade_level = fog_fade_start_level;
	else:
		print("More than one PsycheManager exists!!!");
	pass 

func find_closest_serum_pos() -> Vector3:
	var min_index: int = -1;
	var min_dist: float;
	var player_pos: Vector3 = camera.global_position;
	for i in range(0, first_free_index):
		var subtracted_vector: Vector3 = serum_positions[i] - player_pos;
		var distance_sqr = subtracted_vector.length_squared();
		if(min_index == -1 || distance_sqr < min_dist):
			min_index = i;
			min_dist = distance_sqr;
	return serum_positions[min_index] if min_index != -1 else Vector3.ZERO;

func find_closest_serum() -> Node3D:
	var min_index: int = -1;
	var min_dist: float;
	var player_pos: Vector3 = camera.global_position;
	for i in range(0, first_free_index):
		var subtracted_vector: Vector3 = serum_positions[i] - player_pos;
		var distance_sqr = subtracted_vector.length_squared();
		if(min_index == -1 || distance_sqr < min_dist):
			min_index = i;
			min_dist = distance_sqr;
	return serums[min_index] if min_index != -1 else null;

func find_closest_serum_with_fov(fov: float) -> Node3D:
	var min_index: int = -1;
	var min_dist: float;
	var player_pos: Vector3 = camera.global_position;
	for i in range(0, first_free_index):
		var subtracted_vector: Vector3 = serum_positions[i] - player_pos;
		var direction = subtracted_vector.normalized();
		var dot: float = -player.global_basis.z.dot(direction);
		if(dot < 1-fov/180): continue;
		var distance_sqr = subtracted_vector.length_squared();
		if(min_index == -1 || distance_sqr < min_dist):
			min_index = i;
			min_dist = distance_sqr;
	return serums[min_index] if min_index != -1 else null;

func _physics_process(delta: float) -> void:
	if(craving_timer > 0):
		craving_timer -= delta;
		var closest_serum: Node3D = find_closest_serum_with_fov(craving_serum_fov); # vs find_closest_serum()
		if(closest_serum == null): return;
		var closest_serum_pos: Vector3 = closest_serum.global_position;
		var direction: Vector3 = (closest_serum_pos - player.global_position).normalized();
		# var dot: float = -player.global_basis.z.dot(direction);
		# if(dot < 1-craving_serum_fov/180): dot = 0;
		player.global_translate(direction * craving_player_force * delta);

		var distance_sqr = (closest_serum_pos - player.global_position).length_squared();
		if(distance_sqr < craving_serum_take_radius*craving_serum_take_radius):
			unregister_serum(closest_serum);
			closest_serum.queue_free();
			take_serum();	
	if(overtake_timer > 0):
		overtake_timer -= delta;
		player.global_translate(overtake_dir * overtake_player_force * delta);


func _process(delta: float) -> void:
	serum_level -= serum_drop_rate * delta;
	if(serum_level < 0):
		# print("Player Dead!!!"); Raczej gracz nie powinnien umierać tutaj
		serum_level = 0;
		EventBus.shells_appear.emit();
	if(serum_level > 100):
		# print("Player Dead !!!");
		serum_level = 100;
	if(invisibility_timer > 0):
		invisibility_timer -= delta;
		if(invisibility_timer <= 0):
			EventBus.shells_appear.emit();
	#if(Input.is_key_pressed(KEY_R)):
	#	print(find_closest_serum());
	fog_fade_level -= fog_fade_drop_rate * delta;
	if(fog_fade_level < 0):
		fog_fade_level = 0;
	if(Input.is_key_pressed(KEY_P)):
		craving_timer = randf_range(min_craving_timer, max_craving_timer);
	if(environment.fog_density < normal_fog_density):
		environment.fog_density += delta * serum_to_normal_fog_speed;
	var vignette_intensity: float = vignette_texture.material.get_shader_parameter("intensity");
	if(vignette_intensity > 0):
		vignette_texture.material.set_shader_parameter("intensity", vignette_intensity - (delta*serum_to_normal_vignette_speed)); 
	var saturation: float = saturation_texture.material.get_shader_parameter("saturation");
	if(saturation < normal_saturation):
		saturation_texture.material.set_shader_parameter("saturation", saturation + (delta*serum_to_normal_saturation_speed));

		
func take_serum():
	serum_level += serum_take_amount;
	invisibility_timer = serum_invisibility_time;
	if(invisibility_timer > 0): EventBus.shells_disappear.emit();
	print("fog fade level: ", fog_fade_level, " / serum level: ", serum_level);
	if(serum_level >= fog_fade_level):
		environment.fog_density = serum_fog_density;
		fog_fade_level += fog_fade_addiction_addition;
	if(serum_level < serum_overdose_level):
		set_vignette_parameters(serum_vignette_intensity, serum_vignette_color, serum_vignette_radius);
	elif(serum_level < serum_critical_level):
		overtake_timer = randf_range(min_overtake_timer, max_overtake_timer);
		overtake_dir = Vector3(randf_range(-1, 1), 0 , randf_range(-1, 1)).normalized();
		saturation_texture.material.set_shader_parameter("saturation", overdose_saturation);
		set_vignette_parameters(serum_overdose_vignette_intensity, serum_overdose_vignette_color, serum_overdose_vignette_radius);
	else:
		overtake_timer = 0;
		craving_timer = randf_range(min_craving_timer, max_craving_timer);
		saturation_texture.material.set_shader_parameter("saturation", critical_saturation);
		set_vignette_parameters(serum_critical_vignette_intensity, serum_critical_vignette_color, serum_critical_vignette_radius);

func set_vignette_parameters(intensity: float, color: Color, radius: float) -> void:
	vignette_texture.material.set_shader_parameter("intensity", intensity);
	vignette_texture.material.set_shader_parameter("vignette_color", color);
	vignette_texture.material.set_shader_parameter("radius", radius);
