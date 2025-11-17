extends Node

class_name State

signal Transitioned

@onready var state_machine: State_machine = $"../"
@export var nav_agent: NavigationAgent3D

var state_is_active: bool = true

@export var move_speed = 5.0
	
func Enter():
	state_is_active = true	
	nav_agent.move_speed = move_speed
	
func Exit():
	state_is_active = false
	
func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	pass

func change_state_to(_new_state_name: String):
	state_machine.transit_to_state(self, _new_state_name)
