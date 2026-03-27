extends Resource
class_name PromptReply

var entry: ReplyElement
var filler: ReplyElement
var reply: ReplyElement

func _init(_entry: ReplyElement, _filler: ReplyElement, _reply: ReplyElement) -> void:
    entry = _entry
    filler = _filler
    reply = _reply

func get_text():
    return '\n'.join([entry.text, filler.text, reply.text])

func get_weight():
    return entry.question_weight + filler.question_weight + filler.question_weight
