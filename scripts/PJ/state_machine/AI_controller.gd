extends NavigationAgent3D
#Odpowiada za nadawanie prędkości ruchu i targeta dla navAgent3D

@onready var mob: CharacterBody3D = $"../"
@export var general_move_speed: float = 1.0
@export var acceleration: float=1 # jak szybko agent nabiera i traci prędkość move_speed
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
	if(destination != mob.global_position): 
		var local_destination = destination - mob.global_position
		var direction = local_destination.normalized()
		var direction_flat = Vector3(direction.x, 0, direction.z).normalized()
		mob.look_at(mob.global_position + direction_flat, Vector3.UP)
		#var direction_angle = acos(direction.dot(Vector3.FORWARD))
		#mob.rotation = Vector3.FORWARD.rotated(Vector3.UP, direction_angle)
	#if (get_parent().name == "Shell"):
		#print(mob.velocity.length())
		#print(move_speed)
	var _y_vel = mob.velocity.y
	var acc_coeff = 1
	var forward = -mob.transform.basis.z
	if (abs(mob.velocity.dot(forward) - move_speed) > 0.5):
		if (mob.velocity.dot(forward) < move_speed):
			acc_coeff = 1
			print ("acc")
		else : 
			acc_coeff = -1
		mob.velocity += acc_coeff * acceleration * delta * -mob.transform.basis.z
	else: mob.velocity = -mob.transform.basis.z * move_speed
	mob.velocity.y = _y_vel
	mob.move_and_slide()

func update_target_pos_every(_update_target_pos_timer: float):
	if target:
		set_target_position(target.position)
	timer = get_tree().create_timer(_update_target_pos_timer)
	await timer.timeout
	if is_active:
		update_target_pos_every(update_target_pos_timer)
		
func update_target():
	timer.stop()
