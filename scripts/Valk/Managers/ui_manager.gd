class_name UIManager
extends Node

static var instance: UIManager;

@export var note_ui: Node;

func _ready() -> void:
	if(instance == null):
		instance = self;    
		remove_child(note_ui);
	else:
		print("More than one UIManager exists!!!");
		queue_free();
		
func show_note_ui(note_content: String) -> void:
	add_child(note_ui);
	note_ui.get_node("RichTextLabel").text = note_content;

func hide_note_ui() -> void:
	remove_child(note_ui);
