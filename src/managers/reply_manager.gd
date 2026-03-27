extends Node

var _replies: ReplyList = preload("res://const_data/prompt_reply/reply_list.tres")

signal reply_completed(ready_reply: PromptReply)
signal text_on_change(text: String)
signal new_answers_ready(answers: Array[ReplyElement])
signal reply_selected(reply_element: ReplyElement)

func _ready() -> void:
	reply_selected.connect(load_element)
	reply_completed.connect(_handle_change)

func _handle_change(_e):
	EventManager.pop_back_to_current()


var _reply := PromptReply.new()

func init_data():
	new_answers_ready.emit(_get_starts())

func load_element(element: ReplyElement):
	if _reply.start == null:
		_reply.start = element
		new_answers_ready.emit(_get_fillers())
	elif _reply.filler == null:
		_reply.filler = element
		new_answers_ready.emit(_get_ends())
	else:
		_reply.end = element
		print("Reply completed: " + _reply.get_text())
		reply_completed.emit(_reply)

	text_on_change.emit(_reply.get_text())

	if _reply.end != null:
		_reply = PromptReply.new()

func get_n_random_elements(elements: Array, n: int):
	elements.shuffle()
	return elements.slice(0, n)

func _get_starts():
	return get_n_random_elements(_replies.starts, 5)

func _get_fillers():
	return get_n_random_elements(_replies.fillers, 5)

func _get_ends():
	return get_n_random_elements(_replies.ends, 5)
