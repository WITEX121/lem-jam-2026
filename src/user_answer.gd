class_name UserAnswer extends PanelContainer


@onready var contents: Label = %Contents

func _ready():
	# JAK NOWE PYTANIE TO POKAZUJEMY JE #KAROL
	GameManager.answer_provided.connect(_on_answer_provided)
	GameManager.new_question.connect(_on_new_question)
	

func _on_answer_provided(answer: String):
	contents.text = answer
	visible = true
	

func _on_new_question(question: String):
	visible = false
