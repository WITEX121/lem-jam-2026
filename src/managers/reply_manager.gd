extends Node
class_name ReplyManager

var _replies: ReplyList = preload("res://const_data/prompt_reply/reply_list.tres")

signal reply_completed(ready_reply: PromptReply)
var reply := PromptReply.new()

func load_element(element: ReplyElement):
	if reply.start == null:
		reply.start = element
	elif reply.filler == null:
		reply.filler = element
	else:
		reply.end = element
		reply_completed.emit(reply)
		reply = PromptReply.new()

func get_n_random_elements(elements: Array, n: int):
	elements.shuffle()
	return elements.slice(0, n)

func get_starts():
	return get_n_random_elements(_replies.starts, 5)

func get_fillers():
	return get_n_random_elements(_replies.fillers, 5)

func get_ends():
	return get_n_random_elements(_replies.ends, 5)


