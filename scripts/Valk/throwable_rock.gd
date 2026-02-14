extends RigidBody3D

var player_pos: Vector3;
@onready var signal_emmited: bool = false;

func _ready() -> void:
	contact_monitor = true;
	max_contacts_reported = 1;
	continuous_cd = true;

func _on_body_entered(body: Node) -> void:
	if(signal_emmited): return;
	if(body.name == "Shell"):
		EventBus.sound_emitted_by_player.emit(player_pos);
	else:
		EventBus.sound_emitted_by_player.emit(global_position);
	signal_emmited = true;
