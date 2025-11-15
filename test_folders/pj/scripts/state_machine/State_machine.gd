extends Node

@export var initial_state: State
@export var mob: CharacterBody3D
var current_state : State
var states : Dictionary = {}

func _ready():
	if get_parent() is CharacterBody3D:
		mob = get_parent()
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child 
			child.Transitioned.connect(transit_to_state)
		if initial_state:
			initial_state.Enter()
			current_state = initial_state

func _process(delta):
	if current_state:
		current_state.Update(delta)
		
func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)

func transit_to_state(_state, _new_state_name, _target_pos: Vector3 = Vector3.ZERO):
	if _state != current_state:
		return
	var _new_state = states.get(_new_state_name.to_lower())
	if !_new_state:
		return
	mob.get_node("NavigationAgent3D").state_pos = _target_pos
	if current_state:
		current_state.Exit()
		
	_new_state.Enter()
	current_state = _new_state 
