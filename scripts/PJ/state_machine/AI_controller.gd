extends NavigationAgent3D

@onready var mob: CharacterBody3D = $"../"
@export var general_move_speed: float = 1.0
var move_speed : float = 2.0
var update_target_pos_timer: float = 1.0
var target: Node3D
var is_active: bool = true
var timer

func _ready() -> void:
	mob = get_parent()
	update_target_pos_every(update_target_pos_timer)
	
func _physics_process(delta: float):
	var destination = get_next_path_position()
	var local_destination = destination - mob.global_position
	var direction = local_destination.normalized()
	var _y_vel = mob.velocity.y
	mob.velocity = direction.normalized() * move_speed
	mob.velocity.y = _y_vel
	mob.move_and_slide()

func update_target_pos_every(_update_target_pos_timer: float):
	if target:
		set_target_position(target.position)
	timer = get_tree().create_timer(_update_target_pos_timer)
	print(target.position)
	await timer.timeout
	if is_active:
		update_target_pos_every(update_target_pos_timer)
		
func update_target():
	timer.stop()
