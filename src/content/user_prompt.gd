class_name UserPrompt extends PanelContainer


@onready var contents: Label = %Contents

func _ready():
	# JAK NOWE PYTANIE TO POKAZUJEMY JE #KAROL
	GameManager.new_question.connect(_on_new_question)

func _on_new_question(question: String):
	contents.text = question
	GameManager.start_answer.emit()
	GameManager.answer_provided.emit("TODO: DODAĆ TEKST ODPOWIEDZI")
