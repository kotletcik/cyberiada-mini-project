extends Node3D

var isOpened: bool = false
var isInteracting: bool = false
@export var isDisposable: bool = false
@export var move_distance:= 2.0
@export var open_duration:= 1.0
@export var second_door: Node3D


func player_interact():
	if (!isInteracting):
		isInteracting = true
		if (isDisposable && isOpened): return
		else: switch_open()

func switch_open():
	if (isInteracting):
		var start_pos = global_position
		var second_door_start_local_pos_z = second_door.position.z
		var start_time = Time.get_ticks_msec()
		while ((global_position - start_pos).length() < move_distance/2 - 0.01):
				
			var now = Time.get_ticks_msec()
			var delta = (now - start_time) / 1000.0
			var opened_bool_coeff: = 1
			if (isOpened): opened_bool_coeff = -1
			
			global_position = start_pos + opened_bool_coeff * move_distance * sin(delta * (PI) / open_duration) * transform.basis.z / 2
			second_door.position.z = second_door_start_local_pos_z + opened_bool_coeff * move_distance * sin(delta * (PI) / open_duration) * -1
			await get_tree().process_frame
		isOpened = !isOpened
		isInteracting = false
