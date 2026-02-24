extends Behaviour

@export var start_pos: = []
@onready var nav_agent: NavigationAgent3D = $"../../NavigationAgent3D"
@onready var mesh_instance: MeshInstance3D = $"../../MeshInstance3D"
@export_group("follow_player")
@export var follow_state_duration:= 5.0
@export_group("searching_player")
@export var searching_time: float = 5.0
@export_group("follow_sound")
@export var follow_sound_state_duration:= 2.0
@export var sound_target: Node3D
@export_group("wander")
@export var wander_time: float = 10.0

func _ready() -> void:
	player = state_machine.mob.player
	
func _process(delta: float) -> void:
	Check_conditions(delta)

func Check_conditions(delta: float) -> void:
	var current = state_machine.current_state.state_type
	match current:
		STATE_TYPES.Follow_player:
			if ((state_machine.mob.position) - (player.position)).length() < attack_range:
				#var _timer = get_tree().create_timer(0.5)
				#await _timer.timeout
				change_state_by_name(STATE_TYPES.Follow_player,STATE_TYPES.Attack)
				#change_state_to("wander")
			elif time > 0:
				time-=delta
			else:
				change_state_by_name(STATE_TYPES.Follow_player,STATE_TYPES.Searching)
			if(PsycheManager.instance.invisibility_timer > 0):
				change_state_by_name(STATE_TYPES.Follow_player,STATE_TYPES.Wander)
		STATE_TYPES.Searching:
			if timer > 0:
				timer -= delta
				if (is_player_in_sight()):
					if (PsycheManager.instance.invisibility_timer <= 0): 
						change_state_by_name(STATE_TYPES.Searching,STATE_TYPES.Follow_player);
			else:
				change_state_by_name(STATE_TYPES.Searching,STATE_TYPES.Wander)
		STATE_TYPES.Follow_sound:
			if (is_player_in_sight()):
				if (PsycheManager.instance.invisibility_timer <= 0): change_state_by_name(STATE_TYPES.Follow_sound,STATE_TYPES.Follow_player);
			if ((state_machine.mob.position) - (sound_target.position)).length() < attack_range:
				#var _timer = get_tree().create_timer(0.5)
				#await _timer.timeout
				change_state_by_name(STATE_TYPES.Follow_sound,STATE_TYPES.Wander)
			elif time > 0:
				time-=delta
			else:
				change_state_by_name(STATE_TYPES.Follow_sound,STATE_TYPES.Wander)
		STATE_TYPES.Wander:
			if (is_player_in_sight()):
				if (PsycheManager.instance.invisibility_timer <= 0): 
					change_state_by_name(STATE_TYPES.Wander,STATE_TYPES.Follow_player);
			if timer > 0:
				timer -= delta
			else: 	
				timer = wander_time 
		
func Enter_state(state: int):
	match state:
		STATE_TYPES.Follow_player:
			timer = follow_state_duration
		STATE_TYPES.Searching:
			EventBus.connect("sound_emitted_by_player", change_state_to_follow_sound)
			timer = searching_time
		STATE_TYPES.Follow_sound:
			timer = follow_state_duration
			# Valk: dodałem aby potwór szedł do najnowszego dzwięku
			EventBus.connect("sound_emitted_by_player", change_state_to_follow_sound)
		STATE_TYPES.Wander:
			timer=wander_time
			EventBus.connect("sound_emitted_by_player", change_state_to_follow_sound)
	time=timer

func Exit_state(state: int):
	match state:
		STATE_TYPES.Searching:
			EventBus.disconnect("sound_emitted_by_player", change_state_to_follow_sound)
		STATE_TYPES.Wander:
			EventBus.disconnect("sound_emitted_by_player", change_state_to_follow_sound)
		STATE_TYPES.Follow_sound:
			EventBus.disconnect("sound_emitted_by_player", change_state_to_follow_sound)

func is_player_in_sight() -> bool:
	if (state_machine != null):
		var subtracted_vector: Vector3 = player.position - state_machine.mob.position;
		var direction = subtracted_vector.normalized();
		var dot: float = -state_machine.mob.global_basis.z.dot(direction);
		if(dot < 1-(player_sight_fov/180)): return false;
		var isPlayerInRange: bool = ((state_machine.mob.position) - (player.position)).length() < player_sight_range;
		return isPlayerInRange
	else: return false

func change_state_to_follow_sound(sound_pos: Vector3):
	state_machine.target = sound_pos
	change_state_to(state_machine.current_state, STATE_TYPES.Follow_sound)

func change_state_to(current_state: State, _new_state: int):
	state_machine.transit_to_state(current_state, _new_state)

func change_state_by_name(current_state: int, _new_state: int):
	state_machine.transit_to_state_by_name(current_state, _new_state)
