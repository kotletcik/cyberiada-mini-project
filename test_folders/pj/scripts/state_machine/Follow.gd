extends State
class_name EnemyFollow


@export var enemy: CharacterBody3D
@export var move_speed := 2.0
var player: CharacterBody3D

func Enter():
	player = enemy.get_parent().player

func Physics_Update(delta: float):
	var direction = player.global_position - enemy.global_position

	if direction.length() > 2:
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector3()
