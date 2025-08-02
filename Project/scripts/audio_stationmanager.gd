extends Node

var test_dialogue = load("res://dialogues/test.dialogue")
var shape_dial : Node

class ShapeStation:
	var shape: String
	var audio: AudioStream
	var dialogname : String

	func _init(s: String, st: AudioStream, t: String):
		shape = s
		audio = st
		dialogname = t

var shapeStations : Array[ShapeStation] = []

func _ready():
	shape_dial = get_node("../ShapeDial")
	print(shape_dial)
	DialogueManager.dialogue_started.connect(dialogue_started)
	DialogueManager.show_dialogue_balloon(test_dialogue, "start")

	


func try_to_start_audio():
	var dialog_code = shape_dial.get_dial_code()

func dialogue_started():
	print(shape_dial)