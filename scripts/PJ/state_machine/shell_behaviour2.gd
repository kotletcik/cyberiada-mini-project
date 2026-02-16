extends Behaviour

#follow_player
@export var follow_state_duration:= 5.0
#searching_player
@export var searching_time: float = 5.0
#follow_sound
@export var follow_sound_state_duration:= 2.0
@export var sound_target: Node3D
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
				change_state_by_name(State.types.Follow_player,State.types.Attack)
				#change_state_to("wander")
			elif time > 0:
				time-=delta
			else:
				change_state_by_name(State.types.Follow_player,State.types.Searching)
			if(PsycheManager.instance.invisibility_timer > 0):
				change_state_by_name(State.types.Follow_player,State.types.Wander)
		State.types.Searching:
			if timer > 0:
				timer -= delta
				if (state_machine.mob.is_player_in_sight()):
					if (PsycheManager.instance.invisibility_timer <= 0): 
						change_state_by_name(State.types.Searching,State.types.Follow_player);
			else:
				change_state_by_name(State.types.Searching,State.types.Wander)
		State.types.Follow_sound:
			if (state_machine.mob.is_player_in_sight()):
				if (PsycheManager.instance.invisibility_timer <= 0): change_state_by_name(State.types.Follow_sound,State.types.Follow_player);
			if ((state_machine.mob.position) - (sound_target.position)).length() < state_machine.mob.attack_range:
				#var _timer = get_tree().create_timer(0.5)
				#await _timer.timeout
				change_state_by_name(State.types.Follow_sound,State.types.Wander)
			elif time > 0:
				time-=delta
			else:
				change_state_by_name(State.types.Follow_sound,State.types.Wander)
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
		State.types.Searching:
			EventBus.connect("sound_emitted_by_player", change_state_to_follow_sound)
			timer = searching_time
		State.types.Follow_sound:
			timer = follow_state_duration
			# Valk: dodałem aby potwór szedł do najnowszego dzwięku
			EventBus.connect("sound_emitted_by_player", change_state_to_follow_sound)
		State.types.Wander:
			timer=wander_time
			EventBus.connect("sound_emitted_by_player", change_state_to_follow_sound)
	time=timer

func Exit_state(state: State.types):
	match state:
		State.types.Searching:
			EventBus.disconnect("sound_emitted_by_player", change_state_to_follow_sound)
		State.types.Wander:
			EventBus.disconnect("sound_emitted_by_player", change_state_to_follow_sound)
		State.types.Follow_sound:
			EventBus.disconnect("sound_emitted_by_player", change_state_to_follow_sound)


func change_state_to_follow_sound(sound_pos: Vector3):
	state_machine.target = sound_pos
	change_state_to(state_machine.current_state, State.types.Follow_sound)

func change_state_to(current_state: State, _new_state: State.types):
	state_machine.transit_to_state(current_state, _new_state)

func change_state_by_name(current_state: State.types, _new_state: State.types):
	state_machine.transit_to_state_by_name(current_state, _new_state)
