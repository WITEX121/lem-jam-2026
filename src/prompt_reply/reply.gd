extends Resource
class_name PromptReply

var start: ReplyElement
var filler: ReplyElement
var end: ReplyElement

func is_null():
	return start == null || filler == null || end == null

func get_text():
	return  ' '.join([
		(start.text if start else 'Analizowanie danych'),
		(filler.text if filler else ''),
		(end.text if end else '')
	])

func get_weight():
	var weight = 0.0
	if start: weight += start.question_weight
	if filler: weight += filler.question_weight
	if end: weight += end.question_weight
	return weight