class_name Event extends Resource

enum EventId {
	START_EVENT
}

enum Type { MONEY = 0, MORALITY = 1, TRUST = 2, PR = 3 }

@export var text: String = ""

@export var affirmation_effects: Array[float] = [0, 0, 0, 0];
@export var refutation_effects: Array[float] = [0, 0, 0, 0];

@export var affirmation_events: Array[Event.EventId] = []
@export var refutation_events: Array[Event.EventId] = []