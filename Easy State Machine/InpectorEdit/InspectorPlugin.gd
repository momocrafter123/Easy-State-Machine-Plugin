extends EditorInspectorPlugin

var stateSelector = preload("uid://xwic05lrk7s5") #StateSelectorGrid.gd

func _can_handle(object: Object) -> bool:
	if object is StateMachine:
		return true
	return false

func _parse_property(object, type, name, hint_type, hint_string, usage_flags, wide):
	if hint_string == "StateSaver":
		add_property_editor(name, stateSelector.new(object))
		return true
