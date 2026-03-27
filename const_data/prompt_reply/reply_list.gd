extends Resource
class_name ReplyList

@export var starts: Array[ReplyElement]
@export var fillers: Array[ReplyElement]
@export var ends: Array[ReplyElement]

func random_reply() -> PromptReply:
    return PromptReply.new(starts.pick_random(), fillers.pick_random(), ends.pick_random())
