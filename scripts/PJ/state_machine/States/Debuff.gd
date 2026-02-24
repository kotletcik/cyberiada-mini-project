extends State
class_name Debuff

	
func Update(_delta: float):
	debuff()

func debuff():
	var sound_pos = GameManager.instance.player.to_global(Vector3(0, 0, -2))
	EventBus.sound_emitted_by_player.emit(sound_pos)	
	state_machine.mob.queue_free()
