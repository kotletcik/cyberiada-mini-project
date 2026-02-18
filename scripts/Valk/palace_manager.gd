class_name PalaceManager
extends Node

static var instance: PalaceManager;

var gathered_clues: Array[Clue] = [null];
var first_free_index: int = 0;

func _ready() -> void:
	if(instance == null):
		instance = self;
	else:
		print("More than one PalaceManager exists!!!");
	pass 

func add_clue(new_clue: Clue):
	print(new_clue.name);
	gathered_clues[first_free_index] = new_clue;
	first_free_index += 1;
	print(first_free_index);
	if(gathered_clues.size() == first_free_index):
		gathered_clues.resize(first_free_index * 2);

func remove_clue(clue_to_remove: Clue):
	for i in range(0, gathered_clues.size()):
		if(gathered_clues[i].name == clue_to_remove.name):
			if(gathered_clues[i].description == clue_to_remove.description):
				gathered_clues.remove_at(i);
				if(first_free_index > 0):
					first_free_index -= 1;
				return;