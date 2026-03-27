class_name UserAnswer extends PanelContainer


@onready var contents: Label = %Contents

func _ready():
	# JAK NOWE PYTANIE TO POKAZUJEMY JE #KAROL
	ReplyManager.reply_completed.connect(_on_answer_provided)
	GameManager.next_question.connect(_on_next_question)

var _add_buffer: String = ""
var _elapsed := 0.0

func _process(delta: float) -> void:
	_elapsed += delta
	if not _add_buffer.is_empty() and _elapsed >= Consts.TYPE_SPEED:
		var next_char = _add_buffer[0]

		contents.text += next_char

		_add_buffer = _add_buffer.substr(1)
		_elapsed = 0

func set_text(text: String):
	contents.text = ""
	_add_buffer = text

func _on_answer_provided(ready_reply: PromptReply):
	var answer = EventManager.current_event.get_user_response(ready_reply.get_weight())
	set_text(answer)
	visible = true


func _on_next_question():
	visible = false
