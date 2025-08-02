extends Node2D

var test_dialogue = load("res://dialogues/test.dialogue")

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(test_dialogue, "start")
	DialogueManager.dialogue_ended.connect(on_dialogue_ended)

func on_dialogue_ended(_resource: DialogueResource):
	Global.go_to_level("desk")
	pass
