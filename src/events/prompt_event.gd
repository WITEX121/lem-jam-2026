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

func get_user_response(weight: int):
	return user_responses[_to_type(weight)]

func _to_string() -> String:
	return name

func _to_type(weight: int) -> ResponseType:
	if weight <= -15: return ResponseType.STRONG_REFUTATION
	elif weight < 0: return ResponseType.REFUTATION
	elif  weight <= 15: return ResponseType.AFFIRMATION
	else: return ResponseType.STRONG_AFFIRMATION

