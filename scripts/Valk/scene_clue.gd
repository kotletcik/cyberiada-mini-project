class_name SceneClue
extends StaticBody3D

@export var clue_to_gather: Clue

func _ready() -> void:
	add_to_group("Clue");
