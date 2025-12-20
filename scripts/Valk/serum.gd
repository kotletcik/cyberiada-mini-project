extends Node

@onready var timer: float = 1.0; 

func _ready() -> void:
	get_parent().add_to_group("Serum");

func _process(delta: float) -> void:
	timer -= delta;
	# if(timer < 0):
	# 	get_parent().queue_free();
