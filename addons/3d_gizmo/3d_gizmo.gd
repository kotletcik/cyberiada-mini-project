@tool
extends EditorPlugin

const MyCustomGizmoPlugin = preload("res://addons/3d_gizmo/custom_gizmos.gd");

var gizmo_plugin = MyCustomGizmoPlugin.new();

func _enable_plugin() -> void:
	# Add autoloads here.
	pass


func _disable_plugin() -> void:
	# Remove autoloads here.
	pass


func _enter_tree() -> void:
	add_node_3d_gizmo_plugin(gizmo_plugin)
	pass


func _exit_tree() -> void:
	remove_node_3d_gizmo_plugin(gizmo_plugin)
	pass
