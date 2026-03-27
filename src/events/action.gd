class_name Action extends Node

static var actions: Dictionary = {
	"*REMOVE_EMPLOYEE": func():
		GameManager.fire_employee()
		pass,
	"*ADD_BASE_EVENTS": func():
		EventManager.unlock_events_shuffle(Consts.BASE_EVENTS)
		pass
}
