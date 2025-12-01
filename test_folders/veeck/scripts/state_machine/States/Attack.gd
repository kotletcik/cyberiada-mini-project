extends State
class_name Attack
	
func Enter():
	super.Enter()
	attack()

func attack():
	EventBus.emit_signal("game_restarted")
