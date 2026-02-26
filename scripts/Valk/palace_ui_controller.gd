extends Control

@export var thought_ui_scene: Resource;

var dragged_clue: Clue = null;
var dragged_thought: ThoughtUI = null;

func _can_drop_data(_at_position: Vector2, _data: Variant) -> bool:
	return true;

func _get_drag_data(_at_position: Vector2) -> Variant:
	dragged_thought = UIManager.instance.get_thought_ui_at(_at_position);
	if(dragged_thought == null): return;
	if(dragged_thought.is_on_thought_path): return;
	dragged_clue = dragged_thought.thought_clue;

	var preview: Control = thought_ui_scene.instantiate();
	dragged_thought.visible = false;
	preview.get_node("TitleText").text = dragged_thought.get_node("TitleText").text;
	preview.get_node("DescText").text = dragged_thought.get_node("DescText").text;

	var c: Control = Control.new();
	c.add_child(preview);
	preview.position = -0.5 * preview.size;

	set_drag_preview(c);
	return dragged_clue;

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var data_clue : Clue = data as Clue;
	print(data_clue.name);
	dragged_thought.visible = true;
	var checked_clue: Clue = UIManager.instance.get_clue_at(at_position);
	if(checked_clue == null): return;
	if(PalaceManager.instance.is_correct_thought(checked_clue, dragged_clue)):
		print("hell yeah");
		PalaceManager.instance.create_thought(dragged_clue);
		UIManager.instance.clear_mind_palace_ui();
		UIManager.instance.update_mind_palace_ui();
	return;
