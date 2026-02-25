class_name SceneClue
extends StaticBody3D

@export var clue_to_gather: Clue

func _ready() -> void:
	add_to_group("Clue");

func player_interact() -> void:
	PalaceManager.instance.add_gathered_clue(clue_to_gather);
	queue_free();
