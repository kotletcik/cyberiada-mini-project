extends Node

class_name State

var state_is_active: bool = true
signal Transitioned


func Enter():
	state_is_active = true
	
func Exit():
	state_is_active = false
	
func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	pass
