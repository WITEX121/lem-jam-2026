class_name Action extends Node

static var actions: Dictionary = {
	"*REMOVE_EMPLOYEE": func():
		GameManager.fire_employee()
		print("Kasujemy klienta!")
		pass
}
