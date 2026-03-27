class_name Ratings extends Node

enum Type { MONEY = 0, MORALITY = 1, TRUST = 2, PR = 3 }
enum Opinion { AFFIRMATION = 0, REFUTATION }

@export var _ratings: Array[float] = [0, 0, 0, 0]

func _init(money = 0, morality = 0, trust = 0, pr = 0):
	set_ratings(money, morality, trust, pr)

func get_rating(type: Type):
	return _ratings[type]

func add_ratings(other: Array[float]):
	for i in range(len(_ratings)):
		_ratings[i] += other[i]

func set_ratings(money, morality, trust, pr):
	_ratings[Type.MONEY] = money
	_ratings[Type.MORALITY] = morality
	_ratings[Type.TRUST] = trust
	_ratings[Type.PR] = pr

static func evaluate_score(score: float) -> Opinion:
	return Opinion.AFFIRMATION if score >= 0 else Opinion.REFUTATION
