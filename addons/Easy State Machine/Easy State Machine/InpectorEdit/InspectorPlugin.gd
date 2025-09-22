extends EditorInspectorPlugin

var stateSelector = preload("uid://xwic05lrk7s5") #StateSelectorGrid.gd

# return true if the object should be handled
func _can_handle(object: Object) -> bool:
	if object is StateMachine:
		return true
	return false

# add control to the beginning of the preperty list
func _parse_begin(object: Object) -> void:
	pass

# add control to the beginning of a category
func _parse_category(object: Object, category: String) -> void:
	pass

# add control to the end of the preperty list
func _parse_end(object: Object) -> void:
	pass

# add control to the beginning of a grouß/ sub-group
func _parse_group(object: Object, group: String) -> void:
	pass

# true will replace the specific property with a custom one
func _parse_property(object, type, name, hint_type, hint_string, usage_flags, wide):
	if hint_string == "StateSaver":
		add_property_editor(name, stateSelector.new(object))
		return true
