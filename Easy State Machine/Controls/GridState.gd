@tool
extends MarginContainer
class_name GridState

signal itemSelected
var focus: bool = false
var state: String

func set_state(name: String, icon: Texture) -> void:
	state = name
	%Label.text = name
	%TextureRect.texture = icon

func _on_mouse_entered() -> void:
	focus = true

func _on_mouse_exited() -> void:
	focus = false

func _input(event: InputEvent) -> void:
	if focus:
		if event is InputEventScreenTouch or event is InputEventMouseButton:
			if event.is_pressed():
				select()

func select() -> void:
	itemSelected.emit(self)

func selected() -> void:
	%TextureRect.self_modulate = Color(1, 0, 0)

func deselect() -> void:
	%TextureRect.self_modulate = Color(1, 1, 1)
