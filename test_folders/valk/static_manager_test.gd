class_name Manager
extends Node3D

static var instance: Manager;

var player_health: int;

func _ready() -> void:
	if(instance == null):
		instance = self;
		player_health = 100;
	else:
		print("More than one StaticManager exists!!!");
		queue_free();
		
func DamagePlayer(damage: int) -> void:
		player_health -= damage;
		if(player_health <= 0):
			player_health = 0;
		

func _process(delta: float) -> void:
	if(Input.is_key_pressed(KEY_K)):
		get_tree().change_scene_to_file("res://test_folders/valk/MainScene.tscn");
