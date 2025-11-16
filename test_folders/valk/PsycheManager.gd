class_name PsycheManager
extends Node3D

static var instance: PsycheManager;

@export var serumOnStart: int;
@export var serumDischargeRate: float;

var serumLevel: float;

@export var camera: Camera3D;
@export var serumFOVMultiplier: float;

@export var normalFogDensity: float;
@export var serumFogDensity: float;

@export var serumToNormalFogSpeed: float;

@onready var baseCameraFOV: float = camera.fov;
@onready var environment: Environment = camera.environment;

func _ready() -> void:
	if(instance == null):
		instance = self;
		serumLevel = serumOnStart;
		print("Camera FOV: ", camera.fov);
		environment.fog_density = normalFogDensity;
	else:
		print("More than one PsycheManager exists!!!");
		queue_free();
	
func _process(delta: float) -> void:
	serumLevel -= delta * serumDischargeRate;
	environment.fog_density += delta * serumToNormalFogSpeed;
	if(environment.fog_density > normalFogDensity):
		environment.fog_density = normalFogDensity;
	if(Input.is_action_just_pressed("Interact")):
		serumLevel += 20;
		camera.fov *= serumFOVMultiplier;
		environment.fog_density = serumFogDensity;
		print("USED SERUM!!!");
	if(serumLevel <= 0):
		get_tree().change_scene_to_file("res://test_folders/valk/ValkScene.tscn");
