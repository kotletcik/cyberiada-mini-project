class_name PsycheManager
extends Node

static var instance: PsycheManager;

var serum_level: float;
@export var serum_drop_rate: float;
@export var player: Node3D;
@export var normal_fog_density: float;
@export var serum_fog_density: float;

@export var serum_to_normal_fog_speed: float;

@export var serum_vignette_intensity: float;
@export var serum_to_normal_vignette_speed: float;

@export var serum_overdose_level: float;
@export var serum_overdose_vignette_intensity: float;
@export var serum_to_normal_overdose_vignette_speed: float;

# @onready var camera: Camera3D = player.get_child(0).get_child(0);
@onready var camera: Camera3D = $"../PlayerValk/Head/Camera3D";
@onready var vignette_texture: TextureRect = $"../PlayerValk/CanvasLayer/TextureRect";
@onready var base_camera_fov: float = camera.fov;
@onready var environment: Environment = camera.environment;


func register_camera(registered_camera: Camera3D) -> void:
	camera = registered_camera;

func _ready() -> void:
	if(instance == null):
		instance = self;
		base_camera_fov = camera.fov;
		environment = camera.environment;
		print("Camera FOV: ", camera.fov);
		environment.fog_density = normal_fog_density;
		camera  = player.get_child(0).get_child(0);
		vignette_texture.material.set_shader_parameter("intensity", 0);
	else:
		print("More than one PsycheManager exists!!!");
	pass 


func _process(delta: float) -> void:
	serum_level -= serum_drop_rate * delta;
	if(serum_level <= 0):
		print("Player Dead!!!");
	if(Input.is_action_just_pressed("Interact")):
		take_serum();
		print("USED SERUM!!!");
	if(environment.fog_density < normal_fog_density):
		environment.fog_density += delta * serum_to_normal_fog_speed;
	var vignette_intensity: float = vignette_texture.material.get_shader_parameter("intensity")
	if(vignette_intensity > 0):
		vignette_texture.material.set_shader_parameter("intensity", vignette_intensity - (delta*serum_to_normal_vignette_speed)); 

		
	
func take_serum():
	serum_level += 20;
	environment.fog_density = serum_fog_density;
	if(serum_level < serum_overdose_level):
		vignette_texture.material.set_shader_parameter("intensity", serum_vignette_intensity);
	else:
		vignette_texture.material.set_shader_parameter("intensity", serum_overdose_vignette_intensity);
