class_name PromptEvent

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

func get_user_response(response_type: ResponseType):
	return user_responses[response_type]

func _to_string() -> String:
	return name
