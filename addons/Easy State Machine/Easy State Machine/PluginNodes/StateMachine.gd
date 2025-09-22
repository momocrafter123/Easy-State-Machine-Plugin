@icon("uid://74lbegajkebr")
extends Node
class_name StateMachine

## The initial state to activate when the state machine starts.
@export var initialState: StateSaver

## A dictionary mapping state names to their corresponding State instances.
var states: Dictionary[String, State] = {}

## A list of states that are bound to the currently active state.
var boundStates: Array[State] = []

## The currently active state.
var selectedState: State

## The previously active state before the last switch.
var previousState: State

# --- Lifecycle ---

## Called when the node enters the scene tree.
## Initializes the state machine by collecting child states and activating the initial state.
func _ready() -> void:
	for child in get_children():
		if child is State:
			states[str(child.name)] = child
	if states.has(initialState.state):
		selectedState = states.get(initialState.state) as State
		selectedState.stateStarted.emit()
	else:
		push_error("Initial State was not selected!")

## Called every frame. Emits the `stateProcess` signal for the active and bound states.
## @param delta Time since the last frame.
func _process(delta: float) -> void:
	if selectedState:
		selectedState.stateProcess.emit(delta)
	for state in boundStates:
		state.stateProcess.emit(delta)

## Called every physics frame. Emits the `statePhysicalProcess` signal for the active and bound states.
## @param delta Time since the last physics frame.
func _physics_process(delta: float) -> void:
	if selectedState:
		selectedState.statePhysicalProcess.emit(delta)
	for state in boundStates:
		state.statePhysicalProcess.emit(delta)

## Called when an input event is received. Emits the `stateInput` signal for the active and bound states.
## @param event The input event.
func _input(event: InputEvent) -> void:
	if selectedState:
		selectedState.stateInput.emit(event)
	for state in boundStates:
		state.stateInput.emit(event)

## Called when an unhandled input event is received. Emits the `stateUnhandledInput` signal for the active and bound states.
## @param event The unhandled input event.
func _unhandled_input(event: InputEvent) -> void:
	if selectedState:
		selectedState.stateUnhandledInput.emit(event)
	for state in boundStates:
		state.stateUnhandledInput.emit(event)

## Called when the node is removed from the scene tree.
## Emits the `stateQueueFreed` signal for the active and bound states.
func _exit_tree() -> void:
	if selectedState:
		selectedState.stateQueueFreed.emit()
	for state in boundStates:
		state.stateQueueFreed.emit()

# --- State Switching by Name ---

## Switches to a state using its name.
## @param name The name of the target state.
## @return True if the switch was successful, false otherwise.
func switch_to_state_by_name(name: String) -> bool:
	if states.has(name):
		return switch_to_state_by_state(states.get(name))
	return false

## Binds a state using its name.
## @param name The name of the state to bind.
func bind_state_by_name(name: String) -> void:
	if states.has(name):
		bind_state_by_state(states.get(name))

## Switches the binding to another state using its name.
## @param name The name of the new state to bind to.
func switch_binding_to_name(name: String) -> void:
	if states.has(name):
		switch_binding_to_state(states.get(name))

# --- State Switching by Instance ---

## Switches to a specific state instance.
## Ends the current state and clears bound states unless the new state is already bound.
## @param state The target state instance.
## @return True if the switch was successful, false otherwise.
func switch_to_state_by_state(state: State) -> bool:
	if states.values().has(state) and state != selectedState:
		selectedState.stateEnded.emit()
		for boundState in boundStates:
			if boundState != state:
				boundState.stateEnded.emit()
		previousState = selectedState
		selectedState = state
		if !boundStates.has(state):
			selectedState.stateStarted.emit()
		boundStates = []
		return true
	return false

## Binds a specific state instance to the current state.
## @param state The state to bind.
func bind_state_by_state(state: State) -> void:
	if states.values().has(state) and !boundStates.has(state) and state != selectedState:
		boundStates.append(state)
		state.stateStarted.emit()

## Switches the binding to another state instance.
## Moves the current active state to bound states and activates the new one.
## This will only work, if the state you want to switch to was previously bound.
## @param state The new state to bind and activate.
func switch_binding_to_state(state: State) -> void:
	if boundStates.has(state) and selectedState != state:
		boundStates.append(selectedState)
		selectedState = state
		boundStates.erase(selectedState)

# --- Getters ---

## Returns the currently active state.
## @return The active State instance.
func get_active_state() -> State:
	return selectedState

## Returns all states currently bound to the active state.
## @return An array of bound State instances.
func get_bound_states() -> Array[State]:
	return boundStates

## Returns the previously active state.
## @return The previous State instance.
func get_previous_state() -> State:
	return previousState
