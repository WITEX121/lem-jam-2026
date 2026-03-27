extends Resource
class_name PromptReply

var start: ReplyElement
var filler: ReplyElement
var end: ReplyElement

func get_text():
	return ' '.join([start.text, filler.text, end.text])

func get_weight():
	return start.question_weight + filler.question_weight + end.question_weight
