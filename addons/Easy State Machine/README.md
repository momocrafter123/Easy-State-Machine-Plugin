# Easy State Machine Plugin
This is a modular, signal-driven state machine for Godot 4.x  
It was designed to manage different states easily with a lot of helpful, prebuilt functions.


# Architecture Overview
- StateMachine: The central node that manages transitions and signal routing.
- State: This node is representing a single behavior or logic state.    


# How to Use
1. Create a StateMachine node.
2. Add one or more State nodes as children.
3. Assign an initialState in the StateMachine.


# Tips & Best Practices
- Use the signals of the States to handle logic only if the State is active.
- Bind States for parallel behaviors. If the main State ends, all bound States will also end.


# State Class Reference
## Signals
- stateStarted  
Emitted when the State becomes active. 

- stateProcess(delta: float)  
Emitted every frame if the State is active.

- statePhysicalProcess(delta: float)   
Emitted every physics frame if the State is active.

- stateInput(event: InputEvent)   
Emitted when an input event is received while the State is active.

- stateUnhandledInput(event: InputEvent)   
Emitted when an unhandled input event is received while the State is active.

- stateEnded   
Emitted when the State is getting turned inactive.

- stateQueueFreed   
Emitted when the StateMachine is queued for deletion while this State is still active.


## State Switching Methods
- switch_to_state_by_name(name: String)  
Switches to another State by name.

- switch_to_state_by_state(state: State)  
Switches to another State by instance.

## Binding Methods
- bind_state_by_name(name: String)   
Binds another State by name to run alongside the current one.

- bind_state_by_state(state: State)    
Binds another State by instance.

- switch_binding_to_name(name: String)  
Replaces the current binding with another State by name.

- switch_binding_to_state(state: State)  
Replaces the current binding with another State by instance.

## Getter Methods
- is_active()  
Returns true if this State is currently active.

- is_bound()   
Returns true if this State is currently bound.

- get_active_state()   
Returns the currently active State.

- get_bound_states()  
Returns all bound States.

- get_previous_state()   
Returns the previously active State.

# StateMachine Class Reference
## Properties
- initialState  
The starting State.

- selectedState   
The currently active State.

- previousState  
The last active State.

- boundStates   
States that are active alongside the main State.

## State Management by Name
- switch_to_state_by_name(name: String)  
Switches to a State by name.

- bind_state_by_name(name: String)  
Binds a State by name.

- switch_binding_to_name(name: String)  
Switches binding to a State by name.

## State Management by Instance
- switch_to_state_by_state(state: State)   
Switches to a State by instance.

- bind_state_by_state(state: State)    
Binds a State by instance.

- switch_binding_to_state(state: State)   
Switches binding to a State by instance.

## Getter Methods
- get_active_state()  
Returns the currently active State.

- get_bound_states()   
Returns all bound States.

- get_previous_state()  
Returns the previously active State.
