extends Resource
class_name PromptReply

var start: ReplyElement
var filler: ReplyElement
var end: ReplyElement

func _init(_start: ReplyElement, _filler: ReplyElement, _end: ReplyElement) -> void:
    start = _start
    filler = _filler
    end = _end

func get_text():
    return '\n'.join([start.text, filler.text, end.text])

func get_weight():
    return start.question_weight + filler.question_weight + end.question_weight
