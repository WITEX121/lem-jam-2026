extends Node

signal event_started(event: PromptEvent)

var current_event: PromptEvent = GameManager.EVENTS["PAPIER_DO_KIBLA"]
var events_stack: Array[PromptEvent] = []

func push_event(event: PromptEvent, push_type: PromptEvent.PushType = PromptEvent.PushType.RANDOM):
	match push_type:
		PromptEvent.PushType.RANDOM:
			_push_event_random(event)
		PromptEvent.PushType.NEXT1:
			_push_event_random_next_n(1, event)
		PromptEvent.PushType.NEXT5:
			_push_event_random_next_n(5, event)

func _push_event_random(event: PromptEvent):
	_push_event_random_next_n(len(events_stack)+1, event)

func _push_event_random_next_n(n: int, event: PromptEvent):
	assert(n > 0)

	var start_idx = len(events_stack)
	var end_idx = max(0, start_idx-n+1)

	var push_idx = randi_range(start_idx, end_idx)
	events_stack.insert(push_idx, event)

func pop_back_to_current():
	if current_event != null:
		_handle_event_ending(current_event)

	if events_stack.is_empty():
		push_event(GameManager.EVENTS["NO_EVENTS"], PromptEvent.PushType.NEXT1)

	current_event = events_stack.pop_back()
	event_started.emit(current_event)

func _handle_event_ending(event: PromptEvent):
	var score = evaluate_score()

	var unlocked_events = []
	var affected_ratings = []

	var opinion := Ratings.evaluate_score(score)
	if opinion == Ratings.Opinion.AFFIRMATION:
		unlocked_events = event.affirmation_events
		affected_ratings = event.affirmation_effects
	else:
		unlocked_events = event.refutation_events
		affected_ratings = event.refutation_effects

	unlock_events(unlocked_events)
	GameManager.ratings.add_ratings(affected_ratings)

func evaluate_score() -> float:
	return 1 if GameManager.selected == 0 else -1

func unlock_events(events: Array[EventRunInfo]):
	for event_run_info: EventRunInfo in events:
		if event_run_info.is_action:
			_perform_action(event_run_info)
			continue

		push_event(
			GameManager.EVENTS[event_run_info.event_name],
			event_run_info.push_type
		)

func unlock_events_shuffle(events: Array[String]):
	for event_name in events:
		events_stack.push_back(GameManager.EVENTS[event_name])
	events_stack.shuffle()

func _perform_action(action: EventRunInfo):
	if Action.actions.has(action.event_name):
		Action.actions[action.event_name].call()
