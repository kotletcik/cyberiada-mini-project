extends CharacterBody3D

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

func _physics_process(delta: float) -> void:
	move_and_slide()
