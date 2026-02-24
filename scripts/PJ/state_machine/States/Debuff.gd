extends State
class_name Debuff

var player: PlayerController

func _ready() -> void:
	player = state_machine.mob.player
	
func Update(_delta: float):
	debuff()

func debuff():
	var sound_pos = state_machine.mob.player.to_global(Vector3(0, 0, -2))
	EventBus.sound_emitted_by_player.emit(sound_pos)	
	state_machine.mob.queue_free()
