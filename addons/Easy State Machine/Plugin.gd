@tool
extends EditorPlugin

var plugin

func _enter_tree() -> void:
	plugin = preload("uid://5038py4jscbu").new() #InspectorPlugin.gd
	add_inspector_plugin(plugin)

func _exit_tree() -> void:
	remove_inspector_plugin(plugin)
