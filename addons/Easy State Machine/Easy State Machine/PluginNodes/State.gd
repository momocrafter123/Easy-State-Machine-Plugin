@icon("uid://dftdly8ugx2l4")
extends Node
class_name State

# --- Signals ---

## Emitted when the state becomes active.
signal stateStarted

## Emitted every frame while the state is active.
## @param delta Time elapsed since the last frame.
signal stateProcess(delta: float)

## Emitted every physics frame while the state is active.
## @param delta Time elapsed since the last physics frame.
signal statePhysicalProcess(delta: float)

## Emitted when an InputEvent is received while the state is active.
## @param event The input event to handle.
signal stateInput(event: InputEvent)

## Emitted when an unhandled InputEvent is received while the state is active.
## @param event The unhandled input event.
signal stateUnhandledInput(event: InputEvent)

## Emitted when the state is deactivated.
signal stateEnded

## Emitted when the state machine is queued for deletion while this state is active.
signal stateQueueFreed

# --- Name-based State Management ---

## Switches to a state by its name.
## @param name The name of the target state.
## @return True if the switch was successful, false otherwise.
func switch_to_state_by_name(name: String) -> bool:
	return get_parent().switch_to_state_by_name(name)

## Binds a state by its name to this state.
## @param name The name of the state to bind.
func bind_state_by_name(name: String) -> void:
	get_parent().bind_state_by_name(name)

## Switches the binding to another state by name.
## This will only work, if the state you want to switch to was previously bound.
## @param name The name of the new state to bind to.
func switch_binding_to_name(name: String) -> void:
	get_parent().switch_binding_to_name(name)

# --- State-based Management ---

## Switches to a specific state instance.
## @param state The target state instance.
## @return True if the switch was successful, false otherwise.
func switch_to_state_by_state(state: State) -> bool:
	return get_parent().switch_to_state(state)

## Binds a specific state instance to this state.
## @param state The state instance to bind.
func bind_state_by_state(state: State) -> void:
	get_parent().bind_state_by_state(state)

## Switches the binding to another state instance.
## @param state The new state instance to bind to.
func switch_binding_to_state(state: State) -> void:
	get_parent().switch_binding_to_state(state)

# --- State Info Getters ---

## Checks if this state is currently active.
## @return True if this state is active, false otherwise.
func is_active() -> bool:
	return get_parent().selectedState == self

## Checks if this state is currently bound.
## @return True if this state is bound, false otherwise.
func is_bound() -> bool:
	return get_parent().boundStates.has(self)

## Returns the currently active state.
## @return The active State instance.
func get_active_state() -> State:
	return get_parent().selectedState

## Returns all states bound to the current state.
## @return An array of bound State instances.
func get_bound_states() -> Array[State]:
	return get_parent().boundStates

## Returns the previously active state.
## @return The previous State instance.
func get_previous_state() -> State:
	return get_parent().previousState
