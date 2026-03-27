extends Resource
class_name ReplyList

@export var starts: Array[ReplyElement]
@export var fillers: Array[ReplyElement]
@export var ends: Array[ReplyElement]

func random_reply() -> PromptReply:
    var reply = PromptReply.new()
    reply.start = starts.pick_random()
    reply.filler = fillers.pick_random()
    reply.end = ends.pick_random()
    return reply
