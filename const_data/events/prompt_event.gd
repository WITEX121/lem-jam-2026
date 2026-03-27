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

enum ResponseType {
	STRONG_AFFIRMATION = 0,
	AFFIRMATION,
	REFUTATION,
	STRONG_REFUTATION
}

var name: String = ""
var text: String = ""

var affirmation_effects: Array[float] = [0, 0, 0, 0];
var refutation_effects: Array[float] = [0, 0, 0, 0];

var affirmation_events: Array[EventRunInfo] = []
var refutation_events: Array[EventRunInfo] = []

var user_responses: Array[String] = []

func _to_string() -> String:
	return name
