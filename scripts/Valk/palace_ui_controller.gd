extends Control

var thought_ui: Node;
@export var thought_ui_scene: Resource;

var dragged_clue: Clue = null;

func _process(delta: float) -> void:
	pass

func meow() -> void:
	print("ug");
	thought_ui = get_node("ThoughtUI");
	print(thought_ui);

func _can_drop_data(_at_position: Vector2, _data: Variant) -> bool:
	return true;

func _get_drag_data(_at_position: Vector2) -> Variant:
	print("meow");
	dragged_clue = UIManager.instance.get_clue_at(_at_position);
	var preview: Control = thought_ui_scene.instantiate();
	thought_ui.visible = false;
	preview.get_node("TitleText").text = thought_ui.get_node("TitleText").text;
	preview.get_node("DescText").text = thought_ui.get_node("DescText").text;
	set_drag_preview(preview);
	return "meow";

func _drop_data(_at_position: Vector2, _data: Variant) -> void:
	print("hau");
	thought_ui.visible = true;
	return;
