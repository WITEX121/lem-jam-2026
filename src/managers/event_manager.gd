class_name EventManager extends Node

signal event_started(event: Event)

var current_event: Event = null
var events_stack: Array[Event] = []

func push_event(event: Event):
    events_stack.push_back(event)

func pop_back_to_current():
    if current_event != null:
        _handle_event_ending(current_event)

    current_event = events_stack.pop_back()
    event_started.emit(current_event)

func _handle_event_ending(event: Event):
    var score = evaluate_score()

    var unlocked_events = []
    var affected_ratings = []

    var opinion = Ratings.evaluate_score(score)
    if opinion == Ratings.Opinion.AFFIRMATION:
        unlocked_events = event.affirmation_events
        affected_ratings = event.affirmation_effects
    else:
        unlocked_events = event.refutation_events
        affected_ratings = event.refutation_effects

    unlock_events(unlocked_events)
    GameManager.ratings.add_ratings(affected_ratings)

func evaluate_score() -> float:
    return 0

func unlock_events(events: Array[Event]):
    for event in events:
        push_event(event)
    events_stack.shuffle()