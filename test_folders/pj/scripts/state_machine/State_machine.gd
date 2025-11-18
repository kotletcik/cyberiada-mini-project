#zarządzanie state'ami mobów z AI
#Musi być child'em CharacterBody3D
#Wszystkie state'y jako child'y (Node 'State')
extends Node
class_name State_machine

@export var initial_state: State
#mob do którego się odnosi ten skrypt
@export var mob: CharacterBody3D

var current_state : State
# key = "nazwa": string, value = state: State
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
	print(states)
	EventBus.connect("game_restarted", transit_to_initial_state)
	EventBus.connect("level_changed", transit_to_initial_state)

#aktualizuje process current_state
func _process(delta):
	if current_state:
		current_state.Update(delta)

func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)

#funckja dla sygnałów
func transit_to_initial_state():
	transit_to_state(current_state, initial_state.name)

#zmiana state'u czyli wył. current state i wł new state
func transit_to_state(_state, _new_state_name:String):
	if _state != current_state:
		return
	var _new_state = states.get(_new_state_name.to_lower())
	if !_new_state:
		return
	if current_state:
		current_state.Exit()
	
	_new_state.Enter()
	current_state = _new_state 
	
