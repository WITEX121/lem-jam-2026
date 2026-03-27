class_name Event extends Resource

enum EventId {
	START = 0,
	PAPIER_DO_KIBLA,
	FAKTURA_Z_DATA,
	MATKA_Z_DZIECKIEM,
	NO_EVENTS_EVENT,
}

@export var text: String = ""

@export var affirmation_effects: Array[float] = [0, 0, 0, 0];
@export var refutation_effects: Array[float] = [0, 0, 0, 0];

@export var affirmation_events_indices: Array[Event.EventId] = []
@export var refutation_events_indices: Array[Event.EventId] = []

func get_affirmation_events() -> Array[Event]:
	var affirmation_events: Array[Event] = []
	for idx in affirmation_events_indices:
		affirmation_events.push_back(GameManager.EVENTS[idx])
	return affirmation_events

func get_refutation_events() -> Array[Event]:
	var refutation_events: Array[Event] = []
	for idx in refutation_events_indices:
		refutation_events.push_back(GameManager.EVENTS[idx])
	return refutation_events
