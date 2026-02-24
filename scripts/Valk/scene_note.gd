extends StaticBody3D

@export var note_to_hold: Note;

func player_interact() -> void:
	print(note_to_hold.title);
	print(note_to_hold.content);
	UIManager.instance.show_note_ui(note_to_hold.content);