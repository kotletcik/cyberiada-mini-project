extends Node
class_name State


#move_speed określonego state'u, można zmienić w każdym state
@export var move_speed:= 5.0
@export var model_color: Color
@onready var state_machine: State_machine = $"../"
var state_is_active: bool = true
signal Transitioned
@export var state_type: int

#Wywoływany zawsze przy przełączeniu na ten state
func Enter():
	state_is_active = true	
	state_machine.nav_agent.move_speed = move_speed
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
	state_machine.mat.albedo_color = model_color

func change_state_to(_new_state: int):
	state_machine.transit_to_state(self, _new_state)
