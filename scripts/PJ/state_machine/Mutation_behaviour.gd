extends Behaviour

#follow_player
@export var follow_state_duration:= 5.0
#wander
@export var wander_time: float = 10.0

func _ready() -> void:
	player = state_machine.mob.player
	
func _process(delta: float) -> void:
	Check_conditions(delta)

func Check_conditions(delta: float) -> void:
	var current = state_machine.current_state.state_type
	match current:
		State.types.Follow_player:
			if ((state_machine.mob.position) - (player.position)).length() < state_machine.mob.attack_range:
				#var _timer = get_tree().create_timer(0.5)
				#await _timer.timeout
				change_state_by_name(State.types.Follow_player,State.types.Debuff)
				#change_state_to("wander")
			elif time > 0:
				time-=delta
			else:
				change_state_by_name(State.types.Follow_player,State.types.Wander)
			if(PsycheManager.instance.invisibility_timer > 0):
				change_state_by_name(State.types.Follow_player,State.types.Wander)
		State.types.Wander:
			if (state_machine.mob.is_player_in_sight()):
				if (PsycheManager.instance.invisibility_timer <= 0): 
					change_state_by_name(State.types.Wander,State.types.Follow_player);
			if timer > 0:
				timer -= delta
			else: 	
				timer = wander_time 
		
func Enter_state(state: State.types):
	match state:
		State.types.Follow_player:
			timer = follow_state_duration
		State.types.Wander:
			timer=wander_time
			EventBus.connect("sound_emitted_by_player", change_state_to_follow_sound)
	time=timer

func Exit_state(state_type: State.types):
	match state_type:
		State.types.Wander:
			EventBus.disconnect("sound_emitted_by_player", change_state_to_follow_sound)

func change_state_to_follow_sound(sound_pos: Vector3):
	state_machine.target = sound_pos
	change_state_to(state_machine.current_state, State.types.Follow_sound)

func change_state_to(current_state: State, _new_state_type: State.types):
	state_machine.transit_to_state(current_state, _new_state_type)

func change_state_by_name(current_state_type: State.types, _new_state_type: State.types):
	state_machine.transit_to_state_by_name(current_state_type, _new_state_type)
