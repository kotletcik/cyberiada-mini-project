extends Node

class_name State

signal Transitioned

@onready var state_machine: State_machine = $"../"
# pathfind jest realizowany za pomocą wbudowanej realizacji Navigation3D
@export var nav_agent: NavigationAgent3D

var state_is_active: bool = true
#move_speed określonego state'u, można zmienić w każdym state
@export var move_speed = 5.0
@export var model_color: Color
#Wywoływany zawsze przy przełączeniu na ten state
func Enter():
	state_is_active = true	
	nav_agent.move_speed = move_speed
	change_color(model_color)
	
#Wywoływany zawsze przy przełączeniu z tego state	
func Exit():
	state_is_active = false

#aktualizowany w state-machine jeśli aktualny state
func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	pass

func change_color(_color: Color):
	state_machine.mat.albedo_color.r = model_color.r
	state_machine.mat.albedo_color.g = model_color.g
	state_machine.mat.albedo_color.b = model_color.b

func change_state_to(_new_state_name: String):
	state_machine.transit_to_state(self, _new_state_name)
