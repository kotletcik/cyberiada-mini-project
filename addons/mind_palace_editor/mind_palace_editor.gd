@tool
extends EditorPlugin


# A class member to hold the dock during the plugin life cycle.
var dock


func _enter_tree():
	# Initialization of the plugin goes here.
	# Load the dock scene and instantiate it.

	# Create the dock and add the loaded scene to it.
	dock = EditorDock.new()

	dock.title = "Mind Palace Editor"

	# Note that LEFT_UL means the left of the editor, upper-left dock.
	dock.default_slot = DOCK_SLOT_LEFT_UL

	# Allow the dock to be on the left or right of the editor, and to be made floating.
	dock.available_layouts = EditorDock.DOCK_LAYOUT_VERTICAL | EditorDock.DOCK_LAYOUT_FLOATING

	add_dock(dock)


func _exit_tree():
	# Clean-up of the plugin goes here.
	# Remove the dock.
	remove_dock(dock)
	# Erase the control from the memory.
	dock.queue_free()