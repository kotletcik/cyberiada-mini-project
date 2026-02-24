class_name UIManager
extends Node

static var instance: UIManager;

@export var note_ui: CanvasLayer;

var cursor_locked_menu: bool = true;
var cursor_locked_game: bool = true;

var is_note_ui_active: bool = false;

var is_in_esc_menu: bool = false;
var is_in_game: bool = true;

func _ready() -> void:
	if(instance == null):
		instance = self;    
		remove_child(note_ui);
		update_cursor();
	else:
		print("More than one UIManager exists!!!");
		queue_free();

# func _process(_delta: float) -> void:
# 	if(Input.is_action_just_pressed("ui_cancel") && is_note_ui_active):
# 		hide_note_ui();
		
func show_note_ui(note_content: String) -> void:
	is_note_ui_active = true;
	is_in_game = false;
	add_child(note_ui);
	note_ui.get_node("RichTextLabel").text = note_content;
	cursor_locked_game = false;
	update_cursor();

func hide_note_ui() -> void:
	is_note_ui_active = false;
	is_in_game = true;
	remove_child(note_ui);
	cursor_locked_game = true;
	update_cursor();

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == Key.KEY_ESCAPE:
			if(is_note_ui_active): return;
			cursor_locked_menu = !cursor_locked_menu;
			is_in_esc_menu = !is_in_esc_menu;
			update_cursor();

func update_cursor() -> void:
	if(!cursor_locked_game || !cursor_locked_menu):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
		print("Cursor unlocked");
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
		print("Cursor locked");
