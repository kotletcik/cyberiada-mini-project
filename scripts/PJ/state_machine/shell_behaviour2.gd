extends Behaviour

@export var state_machine: State_machine
var player: PlayerController
#follow_player
@export var follow_state_duration:= 5.0
#searching_player
@export var searching_time: float = 5.0
#follow_sound
@export var follow_sound_state_duration:= 2.0
@export var sound_target: Node3D
#wander
@export var wander_time: float = 10.0
#general
var timer: float
var time: float
var stateIsActive: bool = true

func _ready() -> void:
	player = state_machine.mob.player
	
func _process(delta: float) -> void:
	Check_conditions(delta)

func Check_conditions(delta: float) -> void:
	var current = state_machine.current_state.name.to_lower()
	match current:
		"follow_player":
			if ((state_machine.mob.position) - (player.position)).length() < state_machine.mob.attack_range:
				#var _timer = get_tree().create_timer(0.5)
				#await _timer.timeout
				change_state_by_name("follow_player","attack")
				#change_state_to("wander")
			elif time > 0:
				time-=delta
			else:
				change_state_by_name("follow_player","searching")
			if(PsycheManager.instance.invisibility_timer > 0):
				change_state_by_name("follow_player","wander")
		"searching":
			if timer > 0:
				timer -= delta
				if (state_machine.mob.is_player_in_sight()):
					if (PsycheManager.instance.invisibility_timer <= 0): 
						change_state_by_name("searching","follow_player");
			else:
				change_state_by_name("searching","wander")
		"follow_sound":
			if (state_machine.mob.is_player_in_sight()):
				if (PsycheManager.instance.invisibility_timer <= 0): change_state_by_name("follow_sound","follow_player");
			if ((state_machine.mob.position) - (sound_target.position)).length() < state_machine.mob.attack_range:
				#var _timer = get_tree().create_timer(0.5)
				#await _timer.timeout
				change_state_by_name("follow_sound","wander")
			elif time > 0:
				time-=delta
			else:
				change_state_by_name("follow_sound","wander")
		"wander":
			if (state_machine.mob.is_player_in_sight()):
				if (PsycheManager.instance.invisibility_timer <= 0): 
					change_state_by_name("wander","follow_player");
			if timer > 0:
				timer -= delta
			else: 	
				timer = wander_time 
		
func Enter_state(state: String):
	match state:
		"follow_player":
			timer = follow_state_duration
		"searching":
			EventBus.connect("sound_emitted_by_player", change_state_to_follow_sound)
			timer = searching_time
		"follow_sound":
			timer = follow_state_duration
			# Valk: dodałem aby potwór szedł do najnowszego dzwięku
			EventBus.connect("sound_emitted_by_player", change_state_to_follow_sound)
		"wander":
			timer=wander_time
			EventBus.connect("sound_emitted_by_player", change_state_to_follow_sound)
	time=timer

func Exit_state(state: String):
	match state:
		"searching":
			EventBus.disconnect("sound_emitted_by_player", change_state_to_follow_sound)
		"wander":
			EventBus.disconnect("sound_emitted_by_player", change_state_to_follow_sound)
		"follow_sound":
			EventBus.disconnect("sound_emitted_by_player", change_state_to_follow_sound)


func change_state_to_follow_sound(sound_pos: Vector3):
	state_machine.target = sound_pos
	change_state_to(state_machine.current_state, "follow_sound")

func change_state_to(current_state: State, _new_state_name: String):
	state_machine.transit_to_state(current_state, _new_state_name)

func change_state_by_name(current_state: String, _new_state_name: String):
	state_machine.transit_to_state_by_name(current_state, _new_state_name)
