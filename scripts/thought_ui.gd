class_name ThoughtUI
extends Control

var thought_clue: Clue;

func set_thought_ui_instance( title: String, desc: String, x_pos: int, y_pos: int, clue: Clue):
	get_node("TitleText").text = title;
	get_node("DescText").text = desc;
	position.x = x_pos;
	position.y = y_pos;
	thought_clue = clue;