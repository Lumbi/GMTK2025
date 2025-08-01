extends Node2D

var test_dialogue = load("res://dialogues/test.dialogue")

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(test_dialogue, "start")
