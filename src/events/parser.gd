class_name Parser extends Node

static func parse_event_info(info: String) -> PromptEvent.PushType:
	match info:
		"RANDOM":
			return PromptEvent.PushType.RANDOM
		"NEXT1":
			return PromptEvent.PushType.NEXT1
		"NEXT5":
			return PromptEvent.PushType.NEXT5

	push_error("Couldn't parse '" + info + "', assuming PromptEvent.PushType = RANDOM")
	return PromptEvent.PushType.RANDOM

static func load_events() -> Dictionary[String, PromptEvent]:
	var file = FileAccess.open("res://const_data/events/events.json", FileAccess.READ)
	var content = file.get_as_text()

	var data = JSON.parse_string(content)

	var events: Dictionary[String, PromptEvent] = {}
	if data != null:
		for row in data:
			var event = PromptEvent.new()
			event.name = row["Name"]
			event.text = row["Text"]

			event.affirmation_effects[0] = row["AffirmationEffects"]["MONEY"]
			event.affirmation_effects[1] = row["AffirmationEffects"]["MORALITY"]
			event.affirmation_effects[2] = row["AffirmationEffects"]["TRUST"]
			event.affirmation_effects[3] = row["AffirmationEffects"]["PR"]

			event.refutation_effects[0] = row["RefutationEffects"]["MONEY"]
			event.refutation_effects[1] = row["RefutationEffects"]["MORALITY"]
			event.refutation_effects[2] = row["RefutationEffects"]["TRUST"]
			event.refutation_effects[3] = row["RefutationEffects"]["PR"]

			for event_data in row["AffirmationEvents"]:
				var info := EventRunInfo.new()
				info.event_name = event_data["EventName"]
				if info.event_name.begins_with("*"):
					info.is_action = true
				else:
					info.push_type = parse_event_info(event_data["PushType"])
				event.affirmation_events.push_back(info)

			for event_data in row["RefutationEvents"]:
				var info := EventRunInfo.new()
				info.event_name = event_data["EventName"]
				if info.event_name.begins_with("*"):
					info.is_action = true
				else:
					info.push_type = parse_event_info(event_data["PushType"])
				event.refutation_events.push_back(info)

			event.user_responses.push_back(row["UserResponses"]["STRONG_AFFIRMATION"])
			event.user_responses.push_back(row["UserResponses"]["AFFIRMATION"])
			event.user_responses.push_back(row["UserResponses"]["REFUTATION"])
			event.user_responses.push_back(row["UserResponses"]["STRONG_REFUTATION"])

			events[event.name] = event
	return events
