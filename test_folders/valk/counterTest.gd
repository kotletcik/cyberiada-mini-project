extends Node3D

func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("Interact")):
		PsycheManager.instance.takeSerum();
	if(Input.is_key_pressed(KEY_E)):
		TestManager.increment();
		position.y += delta;
		print(Manager.instance.player_health);
		Manager.instance.DamagePlayer(1);
