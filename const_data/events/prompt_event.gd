class_name PromptEvent

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

var name: String = ""
var text: String = ""

var affirmation_effects: Array[float] = [0, 0, 0, 0];
var refutation_effects: Array[float] = [0, 0, 0, 0];

# TODO: Fuse into one array
var affirmation_events: Array[String] = []
var affirmation_events_info: Array[PushType] = []

# TODO: Fuse into one array
var refutation_events: Array[String] = []
var refutation_events_info: Array[PushType] = []

var user_responses: Array[String] = []

func get_affirmation_events() -> Array[PromptEvent]:
	var events: Array[PromptEvent] = []
	for event_name in affirmation_events:
		events.push_back(GameManager.EVENTS[event_name])
	return events

func get_refutation_events() -> Array[PromptEvent]:
	var events: Array[PromptEvent] = []
	for event_name in affirmation_events:
		events.push_back(GameManager.EVENTS[event_name])
	return events
