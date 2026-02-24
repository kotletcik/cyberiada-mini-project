extends State
class_name Follow_player

func Enter():
	super.Enter()
	state_machine.nav_agent.target = GameManager.instance.player

func Update(delta: float):
	state_machine.nav_agent.set_target_position(GameManager.instance.player.global_position)
