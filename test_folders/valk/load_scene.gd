extends Node3D


func _ready() -> void:
	get_tree().change_scene_to_file("res://test_folders/valk/ValkScene.tscn");
