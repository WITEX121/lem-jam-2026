class_name EventManager extends Node

signal event_started(event: Event)

var current_event: Event = null
var events_stack: Array[Event] = []

func push_event_random_place(event: Event):
    var add_idx = randi_range(0, len(events_stack))

    events_stack.insert(add_idx, event)

func push_event_front(event: Event):
    events_stack.push_back(event)

func pop_back_to_current():
    current_event = events_stack.pop_back()
    event_started.emit(current_event)