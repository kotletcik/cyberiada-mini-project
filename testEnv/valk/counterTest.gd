extends Node3D

@export var cubeAudio: AudioStreamPlayer3D;

@export var floatSpeed: float;

var currentPlaybackTime: float = 0;

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("Interact")):
		cubeAudio.play(currentPlaybackTime);
	if(Input.is_action_just_released("Interact")): 
		currentPlaybackTime = cubeAudio.get_playback_position();
		cubeAudio.stop();
	if(Input.is_action_pressed("Interact")):
		TestManager.increment();
		position.y += delta * floatSpeed;
