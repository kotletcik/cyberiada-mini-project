extends Node3D



func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	if(Input.is_key_pressed(KEY_E)):
		TestManager.increment();
		position.y += delta;
