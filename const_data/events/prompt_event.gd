class_name PromptEvent extends Resource

enum EventId {
	START = 0,
	PAPIER_DO_KIBLA,
	FAKTURA_Z_DATA,
	MATKA_Z_DZIECKIEM,
	NO_EVENTS_EVENT,
}

enum PushType {
	RANDOM = 0,
	NEXT1,
	NEXT5
}

enum UserResponse {
	
}

@export var name: String = ""
@export var text: String = ""

@export var affirmation_effects: Array[float] = [0, 0, 0, 0];
@export var refutation_effects: Array[float] = [0, 0, 0, 0];

@export var affirmation_events_indices: Array[EventId] = []
@export var affirmation_events_info: Array[PushType] = []

@export var refutation_events_indices: Array[EventId] = []
@export var refutation_events_info: Array[PushType] = []

@export var user_responses: Array[String] = []

func get_affirmation_events() -> Array[PromptEvent]:
	var affirmation_events: Array[PromptEvent] = []
	for idx in affirmation_events_indices:
		affirmation_events.push_back(GameManager.EVENTS[idx])
	return affirmation_events

func get_refutation_events() -> Array[PromptEvent]:
	var refutation_events: Array[PromptEvent] = []
	for idx in refutation_events_indices:
		refutation_events.push_back(GameManager.EVENTS[idx])
	return refutation_events
