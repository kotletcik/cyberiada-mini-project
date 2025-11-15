class_name PsycheManager
extends Node3D

var instance: PsycheManager;

@export var serumOnStart: int;
@export var serumDischargeRate: float;

var serumLevel: float;

func _ready() -> void:
	if(instance == null):
		instance = self;
		serumLevel = serumOnStart;
	else:
		print("More than one PsycheManager exists!!!");
		queue_free();
	
func _process(delta: float) -> void:
	serumLevel -= delta * serumDischargeRate;
	if(serumLevel <= 0):
		serumLevel += 20;
		print("USED SERUM!!!");
