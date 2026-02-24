extends Button

func _ready() -> void:
    pressed.connect(_button_pressed);

func _button_pressed() -> void:
    UIManager.instance.hide_note_ui();