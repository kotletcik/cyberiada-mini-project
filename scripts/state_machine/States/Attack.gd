extends State
class_name Attack
	
func Enter():
	super.Enter()
	
func Update(delta: float):
	attack()

func attack():
	EventBus.level_changed.emit(Game_Manager.current_level)
	
