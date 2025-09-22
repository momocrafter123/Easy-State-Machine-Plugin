extends EditorProperty
class_name StateSelectorGrid

var gridContainer = preload("uid://do76baym0j6y8").instantiate() as GridContainer #GridContainer.tscn
var gridState = preload("uid://4ij0peoyfmgc").instantiate() as GridState #GridState.tscn
var resource = preload("uid://chtj8p1t6ftu0").new() as StateSaver #StateSaver.gd

var selectedState: GridState = null
var updating: bool = false
var gridChildren: Array = []
var stateMashine: StateMachine


func _init(object) -> void:
	stateMashine = object
	gridChildren = object.get_children().filter(func(child): return child is State) as Array[GridState]
	for child in gridChildren:
		var gridStateCopy = gridState.duplicate()
		gridStateCopy.set_state(str(child.name), load("uid://dftdly8ugx2l4"))
		gridStateCopy.connect("itemSelected", Callable(self, "on_item_selected"))
		gridContainer.add_child(gridStateCopy)
	add_child(gridContainer)
	add_focusable(gridContainer)


func on_item_selected(item: GridState):
	if updating:
		return
	if item != selectedState:
		if selectedState:
			selectedState.deselect()
		item.selected()
		selectedState = item
		resource.state = selectedState.state
		emit_changed(get_edited_property(), resource)


func _update_property() -> void:
	var new_value = get_edited_object()[get_edited_property()]
	if new_value:
		new_value = new_value as StateSaver
		for child in gridContainer.get_children():
			if child is GridState:
				if new_value.state == child.state:
					on_item_selected(child)
		return
		updating = true
		resource = new_value
		updating = false
