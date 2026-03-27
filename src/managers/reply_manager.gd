extends Node

var _replies: ReplyList = preload("res://const_data/prompt_reply/reply_list.tres")

signal reply_completed(ready_reply: PromptReply)
signal text_on_change(text: String)
signal new_answers_ready(answers: Array[ReplyElement])
signal reply_selected(reply_element: ReplyElement)


func _init():
	reply_selected.connect(load_element)

var _reply := PromptReply.new()

func init_data():
	new_answers_ready.emit(get_starts())

func load_element(element: ReplyElement):
	print("?test")
	if _reply.start == null:
		_reply.start = element
		new_answers_ready.emit(get_fillers())
	elif _reply.filler == null:
		_reply.filler = element
		new_answers_ready.emit(get_ends())
	else:
		_reply.end = element
		new_answers_ready.emit(get_starts())

	text_on_change.emit(_reply.get_text())

	if _reply.end != null:
		reply_completed.emit(_reply)
		_reply = PromptReply.new()

func get_n_random_elements(elements: Array, n: int):
	elements.shuffle()
	return elements.slice(0, n)

func get_starts():
	return get_n_random_elements(_replies.starts, 5)

func get_fillers():
	return get_n_random_elements(_replies.fillers, 5)

func get_ends():
	return get_n_random_elements(_replies.ends, 5)


