extends RigidBody3D

var player_pos: Vector3;

func _ready() -> void:
    contact_monitor = true;
    max_contacts_reported = 1;
    continuous_cd = true;

func _on_body_entered(body: Node) -> void:
    if(body.name == "Shell"):
        EventBus.sound_emitted_by_player.emit(player_pos);
    else:
        EventBus.sound_emitted_by_player.emit(global_position);
