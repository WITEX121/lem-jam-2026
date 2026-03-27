extends Resource
class_name PromptReply

var start: ReplyElement
var filler: ReplyElement
var end: ReplyElement

func get_text():
	var result =  ' '.join([
		(start.text if start else 'Analizowanie danych'),
		(filler.text if filler else ''),
		(end.text if end else '')
	])

	if not (start and filler and end):
		result += '...'

	return result

func get_weight():
	return start.question_weight + filler.question_weight + end.question_weight
