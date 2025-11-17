extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Serum");
	print(is_in_group("Serum"));


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
